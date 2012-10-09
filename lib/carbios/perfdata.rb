module Carbios

class PerfData
  include Helpers

  attr_reader :time, :hostname

  SERVICEKEY = 'SERVICEPERFDATA'
  HOSTKEY    = 'HOSTPERFDATA'

  def initialize ( checkstr, options = {} )
    @prefix    = options[:prefix]
    parse_checkdata(checkstr)
    @time      = Time.at(@checkdata['TIMET'].to_i)
    @hostname  = Hostname.new( @checkdata['HOSTNAME'], 
                               :base_hostname => options[:base_hostname] )
    @desc      = normalize_key(@checkdata['SERVICEDESC']) if @checkdata['SERVICEDESC']
    parse_perfdata
  end

  def parse_checkdata( checkstr )
    @checkdata = Hash[checkstr.scan(/(.*?)::(?:(.*?)(?:\t+|$))/)]
  end

  def parse_perfdata
    if @checkdata.has_key? SERVICEKEY
      @key = SERVICEKEY
    elsif @checkdata.has_key? HOSTKEY
      @key = HOSTKEY
    else
      raise "Cannot find #{SERVICEKEY} or #{HOSTKEY} keys"
    end
    @perfdata = Hash[@checkdata[@key].scan(/(\S+)=(\d+(?:\.\d+)?)\S*\s?/)]
  end

  def normalize_perfdata
    Hash[@perfdata.map { |k,v| [normalize_key(k), v] }]
  end

  def has_perfdata?
    !@perfdata.empty?
  end

  def to_h
    prefix = [@prefix,@hostname.reverse,@desc].compact.join('.')
    normalize_perfdata.prefix_keys("#{prefix}.")
  end

end # class PerfData

end # module Carbios
