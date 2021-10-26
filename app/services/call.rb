class Call
  @calls = []
  attr_accessor :id, :started, :peers

  def initialize(id)
    self.id = id
    self.started = Time.zone.now
    self.peers = []
  end

  def add_peer(peer_id, current_user_id)
    index = peers.index { |p| p[:current_user_id] == current_user_id }
    peers.delete_at(index) if index.present?

    peers << { peer_id: peer_id, current_user_id: current_user_id }
  end

  def remove_peer(peer_id)
    index = peers.find_index(peer_id)
    peers.delete_at(index) if index.present?
  end

  def self.finish(call_id)
    index = @calls.index { |c| c.id == call_id }
    @calls.delete_at(index) if index.present?
  end

  def self.create(id)
    call = Call.new id
    @calls << call
    call
  end

  def self.get(id)
    calles = @calls.select { |call| call.id == id }
    return nil if calles.blank?

    calles[0]
  end

  def self.get_all
    @calls
  end

  class << self
    attr_accessor :calls
  end
end
