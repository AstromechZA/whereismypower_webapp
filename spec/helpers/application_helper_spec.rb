require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'bootstrap_class_for' do
    it 'works for the symbol case' do
      expect(helper.bootstrap_class_for(:info)).to eq('alert-info')
      expect(helper.bootstrap_class_for(:success)).to eq('alert-success')
      expect(helper.bootstrap_class_for(:notice)).to eq('alert-success')
      expect(helper.bootstrap_class_for(:error)).to eq('alert-danger')
      expect(helper.bootstrap_class_for(:alert)).to eq('alert-danger')
      expect(helper.bootstrap_class_for(:warning)).to eq('alert-warning')
    end

    it 'works for the string case' do
      expect(helper.bootstrap_class_for('info')).to eq('alert-info')
    end

    it 'works for unknown case' do
      expect(helper.bootstrap_class_for(:unknown)).to eq('unknown')
    end
  end

  describe 'text_truncate' do
    it 'works' do
      expect(helper.text_truncate('thing thing thing thing thing', limit=15)).to eq('thing thing...')
    end
  end

end
