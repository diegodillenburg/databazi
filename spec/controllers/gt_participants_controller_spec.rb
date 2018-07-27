require 'rails_helper'

RSpec.describe GtParticipantsController, type: :controller do
  let(:english_level) { build(:english_level) }
  let(:exchange_participant) { build(:exchange_participant) }
  let(:gt_participant) do
    build(:gt_participant, english_level: english_level,
      exchange_participant: exchange_participant)
  end

  describe "#create" do
    subject(:do_create) { post :create, params: { gt_participant: gt_params } }

    let(:gt_params) do
      {
         fullname: gt_participant.fullname,
         email: gt_participant.email,
         cellphone: gt_participant.cellphone,
         birthdate: gt_participant.birthdate,
         english_level: gt_participant.english_level.to_s,
         scholarity: gt_participant.scholarity,
         experience: gt_participant.experience
      }
    end
    let(:response) { JSON.parse(subject.body) }
    it { is_expected.to be_successful }

    context "success" do
      it { expect { do_create }.to change(ExchangeParticipant, :count).by 1 }
      it { expect { do_create }.to change(GtParticipant, :count).by 1 }
      it { expect { do_create }.to change(EnglishLevel, :count).by 1 }

      describe "response" do
        it { expect(response['status']).to eq 'success' }
      end
    end

    context "failure" do
      before { allow_any_instance_of(GtParticipant).to receive(:save).and_return(false) }

      it { expect { do_create }.not_to change(ExchangeParticipant, :count) }
      it { expect { do_create }.not_to change(GtParticipant, :count) }
      it { expect { do_create }.not_to change(EnglishLevel, :count) }

      describe "response" do
        it { expect(response['status']).to eq 'failure' }
      end
    end
  end
end