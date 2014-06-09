require 'spec_helper'

module MangoHandcart
  RSpec.describe IpAddressesController, type: :controller do
    routes { MangoHandcart::Engine.routes }

    # This should return the minimal set of attributes required to create a valid
    # IpAddress. As you add validations to IpAddress, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      attributes_for(:mango_handcart_ip_address)
    }

    let(:invalid_attributes) {
      {
        address: "",
      }
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # IpAddressesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all ip_addresses as @ip_addresses" do
        ip_address = IpAddress.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:ip_addresses)).to eq([ip_address])
      end
    end

    describe "GET show" do
      it "assigns the requested ip_address as @ip_address" do
        ip_address = IpAddress.create! valid_attributes
        get :show, {id: ip_address.to_param}, valid_session
        expect(assigns(:ip_address)).to eq(ip_address)
      end
    end

    describe "GET new" do
      it "assigns a new ip_address as @ip_address" do
        get :new, {}, valid_session
        expect(assigns(:ip_address)).to be_a_new(IpAddress)
      end
    end

    describe "GET edit" do
      it "assigns the requested ip_address as @ip_address" do
        ip_address = IpAddress.create! valid_attributes
        get :edit, {id: ip_address.to_param}, valid_session
        expect(assigns(:ip_address)).to eq(ip_address)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new IpAddress" do
          expect {
            post :create, {ip_address: valid_attributes}, valid_session
          }.to change(IpAddress, :count).by(1)
        end

        it "assigns a newly created ip_address as @ip_address" do
          post :create, {ip_address: valid_attributes}, valid_session
          expect(assigns(:ip_address)).to be_a(IpAddress)
          expect(assigns(:ip_address)).to be_persisted
        end

        it "redirects to the created ip_address" do
          post :create, {ip_address: valid_attributes}, valid_session
          expect(response).to redirect_to(IpAddress.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved ip_address as @ip_address" do
          post :create, {ip_address: invalid_attributes}, valid_session
          expect(assigns(:ip_address)).to be_a_new(IpAddress)
        end

        it "re-renders the 'new' template" do
          post :create, {ip_address: invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          {
            address: '127.0.0.1',
            subnet_mask: '255.255.255.0',
            blacklisted: false,
          }
        }

        it "updates the requested ip_address" do
          ip_address = IpAddress.create! valid_attributes
          put :update, {id: ip_address.to_param, ip_address: new_attributes}, valid_session
          ip_address.reload
          expect(ip_address.address).to eq("127.0.0.1")
        end

        it "assigns the requested ip_address as @ip_address" do
          ip_address = IpAddress.create! valid_attributes
          put :update, {id: ip_address.to_param, ip_address: valid_attributes}, valid_session
          expect(assigns(:ip_address)).to eq(ip_address)
        end

        it "redirects to the ip_address" do
          ip_address = IpAddress.create! valid_attributes
          put :update, {id: ip_address.to_param, ip_address: valid_attributes}, valid_session
          expect(response).to redirect_to(ip_address)
        end
      end

      describe "with invalid params" do
        it "assigns the ip_address as @ip_address" do
          ip_address = IpAddress.create! valid_attributes
          put :update, {id: ip_address.to_param, ip_address: invalid_attributes}, valid_session
          expect(assigns(:ip_address)).to eq(ip_address)
        end

        it "re-renders the 'edit' template" do
          ip_address = IpAddress.create! valid_attributes
          put :update, {id: ip_address.to_param, ip_address: invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested ip_address" do
        ip_address = IpAddress.create! valid_attributes
        expect {
          delete :destroy, {id: ip_address.to_param}, valid_session
        }.to change(IpAddress, :count).by(-1)
      end

      it "redirects to the ip_addresses list" do
        ip_address = IpAddress.create! valid_attributes
        delete :destroy, {id: ip_address.to_param}, valid_session
        expect(response).to redirect_to(ip_addresses_url)
      end
    end

  end
end
