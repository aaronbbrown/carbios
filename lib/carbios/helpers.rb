module Carbios

module Helpers
  def normalize_key (str)
    str.gsub(/\W+/,'_')
  end
end # module Helpers

end # module
