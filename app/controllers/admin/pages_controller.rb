# frozen_string_literal: true

module Admin
  # managing pages
  class PagesController < AdminController
    before_action :set_page, only: %i[show edit update destroy]

    def index
      @pages = Page.all
    end

    def show; end

    def new
      @page = Page.new
    end

    def edit; end

    def create
      @page = Page.new(page_params)

      if @page.save
        redirect_to admin_page_url(@page), notice: 'Page was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @page.update(page_params)
        redirect_to admin_page_url(@page), notice: 'Page was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @page.destroy

      redirect_to admin_pages_url, notice: 'Page was successfully destroyed.'
    end

    private

      def set_page
        @page = Page.friendly.find(params[:id])
      end

      def page_params
        params.require(:page).permit(:title, :keywords, :body, :navigation, :welcome_content, :link_label, :position)
      end
  end
end
