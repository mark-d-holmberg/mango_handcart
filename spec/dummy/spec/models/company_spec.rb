require 'spec_helper'

RSpec.describe Company, type: :model do

  describe "concerning associations" do
    it "should belong to a dns_record" do
      handcart = create(:company)
      expect(handcart.dns_record).to_not be_nil
    end
  end

  describe "concerning Handcart settings" do
    it "should set the dns_record_class class correctly" do
      expect(MangoHandcart.dns_record_class).to eq(MangoHandcart::DnsRecord)
    end

    it "should set the handcart class correctly" do
      expect(MangoHandcart.handcart_class).to eq(Company)
    end
  end

  describe "concerning validations" do
    it "should have a valid factory" do
      expect(build(:company)).to be_valid
    end
  end

  describe "concerning ActiveRecord callbacks" do
    it "should destroy the dns_record when destroying a company" do
      company = create(:company)
      dns_record = company.dns_record
      expect(dns_record).to_not be_nil
      company.destroy
      expect {
        dns_record.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not try to destroy a dns_record if it isn't associated with one" do
      company = create(:company, dns_record: nil)
      expect(company.dns_record).to be_nil
      expect {
        company.destroy
      }.to_not raise_error
    end
  end
end
