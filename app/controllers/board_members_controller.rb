# frozen_string_literal: true

class BoardMembersController < ApplicationController
  def index
    @board_members = BoardMember.current_team.order("role desc, last_name")
  end
end
