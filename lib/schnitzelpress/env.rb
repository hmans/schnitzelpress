module Schnitzelpress
  def self.env
    (ENV['RACK_ENV'] || 'development').inquiry
  end
end
