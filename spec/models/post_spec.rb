# -*- coding: utf-8 -*-

require 'rails_helper'

RSpec.describe Post, :type => :model do
    context "when Category create (valid or invalid)" do
        subject{ Post.all.size }
        before do
            for num in 1..3 do
                create(:valid_no_draft_post)
                create(:invalid_no_draft_post)
            end
        end
        it { should eq(6) }
    end

    context "when Category create (valid only)" do
        subject{ Post.all.valid.size }
        before do
            for num in 1..3 do
                create(:valid_no_draft_post)
                create(:invalid_no_draft_post)
            end
        end
        it { should eq(3) }
    end

    context "when use summary contents" do
        subject { post.summary_contents.length }
        let(:long_contents) {
            "“As he crossed toward the pharmacy at the corner he involuntarily turned his head because of a burst of light that had ricocheted from his temple, and saw, with that quick smile with which we greet a rainbow or a rose, a blindingly white parallelogram of sky being unloaded from the van—a dresser with mirrors across which, as across a cinema screen, passed a flawlessly clear reflection of boughs sliding and swaying not arboreally, but with a human vacillation, produced by the nature of those who were carrying this sky, these boughs, this gliding façade.”"
        }
        let(:post){ create(:valid_no_draft_post, contents: long_contents) }
        it { should eq(203) }
    end

    context "when searching by Tag" do
        subject {  Post.valid.tagged_with(tag).length }
        let(:tag) { "TAG_SAMPLE" }
        before do
            for num in 1..3 do
                create(:valid_no_draft_post, tag_list: tag)
                create(:invalid_no_draft_post, tag_list: tag)
            end
        end
        it { should eq(3) }
    end


end

