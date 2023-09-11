# frozen_string_literal: true

module Admin
  class BoardMembersController < AdminController
    before_action :load_board_member, only: %i[show edit update destroy]

    def index
      @board_members = BoardMember.order(:active, :last_name)
    end

    def show; end

    def new
      @board_member = BoardMember.new
    end

    def create
      @board_member = BoardMember.new(board_member_params)
      if @board_member.save
        redirect_to admin_board_members_path, notice: 'Board Member was successfully created.'
      else
        render :new
      end
    end

    def edit
      @board_member.term_starts_on = Date.parse(@board_member.term_starts_on)
    end

    def update
      if @board_member.update(board_member_params)
        redirect_to admin_board_members_path, notice: 'Boar d Member was successfully updated.'
      else
        @board_member.term_starts_on = Date.parse(@board_member.term_starts_on)
        render :edit
      end
    end

    def destroy
      @board_member.destroy
      redirect_to admin_board_members_path, notice: 'Board Member was successfully destroyed.'
    end

    private

      def load_board_member
        @board_member = BoardMember.friendly.find(params[:id])
      end

      def board_member_params
        params.require(:board_member).permit(
          %i[
            first_name last_name email role active avatar bio
            password password_confirmation term_starts_on term_ends_on
          ]
        )
      end
  end
end
