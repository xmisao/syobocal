class Music
  attr_reader :tiitle, :category, :data_list

  def initialize(title, category, data_list)
    @title, @category, @data_list = title, category, data_list
  end
end
