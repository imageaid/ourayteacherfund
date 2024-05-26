# frozen_string_literal: true

class AwardeesController < ApplicationController

  def index
    @awardees = GrantDecision.where(approved: true).order(created_at: :desc)
  end
end
