require 'spec_helper'

describe Message do
  
  context 'Demonstration of how datamapper works' do

    it 'should be created and then retrieved from the db' do

      expect(Message.count).to eq(0)

      Message.create(title: 'Test',
                     body: 'This is a test')

      expect(Message.count).to eq(1)
      message = Message.first
      expect(message.title).to eq('Test')
      expect(message.body).to eq('This is a test')

      message.destroy
      expect(Message.count).to eq(0)
    end
  end
end