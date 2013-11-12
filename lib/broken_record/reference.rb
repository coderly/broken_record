module BrokenRecord
  Reference = Struct.new(:klass, :id) do

    def to_s
      "#{klass} (id=#{id})"
    end

    def broken?
      id && klass.find_by(id: id).nil?
    end

  end
end
