require 'spec_helper'

module MangoHandcart
  RSpec.describe DnsRecordsController, type: :controller do
    routes { MangoHandcart::Engine.routes }

    # This should return the minimal set of attributes required to create a valid
    # MangoHandcart::DnsRecord. As you add validations to MangoHandcart::DnsRecord, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      attributes_for(:mango_handcart_dns_record)
    }

    let(:invalid_attributes) {
      {name: ""}
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # MangoHandcart::DnsRecordsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all dns_records as @dns_records" do
        dns_record = MangoHandcart::DnsRecord.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:dns_records)).to eq([dns_record])
      end
    end

    describe "GET show" do
      it "assigns the requested dns_record as @dns_record" do
        dns_record = MangoHandcart::DnsRecord.create! valid_attributes
        get :show, {id: dns_record.to_param}, valid_session
        expect(assigns(:dns_record)).to eq(dns_record)
      end
    end

    describe "GET new" do
      it "assigns a new dns_record as @dns_record" do
        get :new, {}, valid_session
        expect(assigns(:dns_record)).to be_a_new(MangoHandcart::DnsRecord)
      end
    end

    describe "GET edit" do
      it "assigns the requested dns_record as @dns_record" do
        dns_record = MangoHandcart::DnsRecord.create! valid_attributes
        get :edit, {id: dns_record.to_param}, valid_session
        expect(assigns(:dns_record)).to eq(dns_record)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new MangoHandcart::DnsRecord" do
          expect {
            post :create, {dns_record: valid_attributes}, valid_session
          }.to change(MangoHandcart::DnsRecord, :count).by(1)
        end

        it "assigns a newly created dns_record as @dns_record" do
          post :create, {dns_record: valid_attributes}, valid_session
          expect(assigns(:dns_record)).to be_a(MangoHandcart::DnsRecord)
          expect(assigns(:dns_record)).to be_persisted
        end

        it "redirects to the created dns_record" do
          post :create, {dns_record: valid_attributes}, valid_session
          expect(response).to redirect_to(MangoHandcart::DnsRecord.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved dns_record as @dns_record" do
          post :create, {dns_record: invalid_attributes}, valid_session
          expect(assigns(:dns_record)).to be_a_new(MangoHandcart::DnsRecord)
        end

        it "re-renders the 'new' template" do
          post :create, {dns_record: invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          {
            name: "mark"
          }
        }

        it "updates the requested dns_record" do
          dns_record = MangoHandcart::DnsRecord.create! valid_attributes
          put :update, {id: dns_record.to_param, dns_record: new_attributes}, valid_session
          dns_record.reload
          expect(dns_record.name).to eql("mark")
        end

        it "assigns the requested dns_record as @dns_record" do
          dns_record = MangoHandcart::DnsRecord.create! valid_attributes
          put :update, {id: dns_record.to_param, dns_record: valid_attributes}, valid_session
          expect(assigns(:dns_record)).to eq(dns_record)
        end

        it "redirects to the dns_record" do
          dns_record = MangoHandcart::DnsRecord.create! valid_attributes
          put :update, {id: dns_record.to_param, dns_record: valid_attributes}, valid_session
          expect(response).to redirect_to(dns_record)
        end
      end

      describe "with invalid params" do
        it "assigns the dns_record as @dns_record" do
          dns_record = MangoHandcart::DnsRecord.create! valid_attributes
          put :update, {id: dns_record.to_param, dns_record: invalid_attributes}, valid_session
          expect(assigns(:dns_record)).to eq(dns_record)
        end

        it "re-renders the 'edit' template" do
          dns_record = MangoHandcart::DnsRecord.create! valid_attributes
          put :update, {id: dns_record.to_param, dns_record: invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested dns_record" do
        dns_record = MangoHandcart::DnsRecord.create! valid_attributes
        expect {
          delete :destroy, {id: dns_record.to_param}, valid_session
        }.to change(MangoHandcart::DnsRecord, :count).by(-1)
      end

      it "redirects to the dns_records list" do
        dns_record = MangoHandcart::DnsRecord.create! valid_attributes
        delete :destroy, {id: dns_record.to_param}, valid_session
        expect(response).to redirect_to(dns_records_url)
      end
    end

  end
end
