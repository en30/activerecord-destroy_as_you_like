require 'spec_helper'
class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy_as_you_like
end

class Post < ActiveRecord::Base
end

describe ActiveRecord::DestroyAsYouLike do
  it 'has a version number' do
    expect(ActiveRecord::DestroyAsYouLike::VERSION).not_to be nil
  end

  describe 'Parent#destroy' do
    let(:user) do
      User.create do |u|
        3.times { u.posts.build }
      end
    end

    %w[before_destroy around_destroy after_destroy after_commit].each do |callback_type|
      context "when children have #{callback_type} callback" do
        around do |example|
          Post.send(callback_type) { yield if block_given? }
          example.run
          Post.reset_callbacks(callback_type.slice(/_(.+)/, 1))
        end

        it 'destroy_all children' do
          expect_any_instance_of(ActiveRecord::Associations::HasManyAssociation).to receive(:destroy_all)
          user.destroy
        end
      end
    end

    context 'when children do not have any destroy related callback' do
      it 'delete_all children' do
        expect_any_instance_of(ActiveRecord::Associations::HasManyAssociation).to receive(:delete_all).with(:delete_all)
        user.destroy
      end
    end
  end
end
