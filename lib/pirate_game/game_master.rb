require 'shuttlecraft/mothership'

class PirateGame::GameMaster


  MIN_PLAYERS = 1 # for now
  MAX_PLAYERS = 4

  STATES = [:pending, :startable, :playing, :ended]

  attr_accessor :stage, :stage_ary

  ##
  # The state of the game. See STATES.

  attr_reader :state

  ##
  # Number of players in the game.  Call #update to refresh

  attr_reader :num_players

  ##
  # Names of players in the game.  Call #update to refresh

  attr_reader :player_names

  def initialize(opts={})
    opts[:protocol] ||= PirateGame::Protocol.default

    @mothership = Shuttlecraft::Mothership.new(opts.merge({:verbose => true, :owner => self}))

    set_state :pending

    @last_update  = Time.at 0
    @num_players  = 0
    @player_names = []
    @stage        = nil
    @stage_ary    = []

    @action_watcher = create_action_watcher
  end

  def registrations_text
    "Num Players: #{@num_players}\n#{@player_names.join(', ')}\n"
  end

  def stage_info
    return unless @stage

    info = "Stage #{@stage.level}: \n"
    if @stage.in_progress?
      info << "Actions: #{@stage.actions_completed}\n"
      info << "Time Left: #{@stage.time_left.to_i} seconds\n"
    else
      info << "Status: #{@stage.status}\n"

      rundown = @stage.rundown

      info << "Actions: #{rundown[:total_actions]}\n"

      rundown[:player_breakdown].each do |player_uri, actions|
        info << "#{player_uri}: #{actions}\n"
      end

    end

    info
  end

  def game_info
    return if @stage_ary.empty?

    info = "Game Rundown:\n"
    gr = game_rundown

    info << "Total Actions: #{gr[:total_actions]}\n"

    gr[:player_breakdown].each do |player_uri, actions|
      info << "#{player_uri}: #{actions}\n"
    end

    info
  end

  def game_rundown
    return {} if @stage_ary.empty?

    rundown = {
      :total_stages => @stage_ary.length,
      :total_actions => @stage_ary.inject(0) {|sum,stage| sum += stage.actions_completed},
      :player_breakdown => {}}

    for stage in @stage_ary
      stage.player_stats.each_pair do |key, value|
        rundown[:player_breakdown][key] ||= 0
        rundown[:player_breakdown][key] += value.size
      end
    end

    rundown
  end

  def allow_registration?
    return (@stage.nil? && @num_players < MAX_PLAYERS)
  end

  def startable?
    update(@mothership.update!)
    return (@stage.nil? || @stage.success?) &&
           @num_players >= MIN_PLAYERS &&
           @num_players <= MAX_PLAYERS
  end

  def increment_stage
    @stage =
      if @stage
        @stage.increment
      else
        PirateGame::Stage.new 1, @num_players
      end

    @stage_ary << @stage
    @stage
  end

  def on_registration
    set_state :startable if startable?
  end

  def start
    return unless startable?

    increment_stage

    return true
  end

  def send_stage_info_to_clients
    if @stage.in_progress?
      set_state :playing
      send_start_to_clients

    elsif @stage.success?
      set_state :startable
      send_return_to_pub_to_clients

    elsif @stage.failure?
      set_state :ended
      send_end_game_to_clients
    end
  end

  def send_start_to_clients
    @mothership.each_client do |client|
      bridge = @stage.bridge_for_player
      client.start_stage(bridge, @stage.all_items)
    end
  end

  def send_return_to_pub_to_clients
    @mothership.each_client do |client|
      client.return_to_pub
    end
  end

  def send_end_game_to_clients
    @mothership.each_client do |client|
      client.end_game game_rundown
    end
  end

  def create_action_watcher
    Thread.new do
      loop do
        handle_action @mothership.take([:action, nil, nil, nil])
      end
    end
  end

  def handle_action action_array
    if @stage && @stage.in_progress?
      @stage.complete action_array[1], action_array[3]
    end
  end

  ##
  # Retrieves the latest data from the TupleSpace.

  def update(services = nil)
    services ||= @mothership.update
    return if services.nil?

    @num_players = services.length

    @player_names = services.map { |name,| name }

    services
  end

  private

  def set_state state
    @state = state if STATES.include? state
  end

end

