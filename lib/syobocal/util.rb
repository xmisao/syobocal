module Syobocal
  module Util
    def self.format_params(params)
      return "" if params.length == 0

      "?" + params.to_a.map { |tuple|
        tuple[0].to_s + "=" + tuple[1].to_s
      }.join("&")
    end

    def self.format_params_amp(params)
      return "" if params.length == 0

      "&" + params.to_a.map { |tuple|
        tuple[0].to_s + "=" + tuple[1].to_s
      }.join("&")
    end
  end
end
