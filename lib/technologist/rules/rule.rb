class Rule
  attr_accessor :framework

  def initialize(framework, attributes = {})
    self.framework = framework

    attributes.each { |name, value| self.send(:"#{name}=", value) }
  end

  def matches?(repository)
    false
  end
end
