# frozen_string_literal: true

module Admin
  # managing pages
  class PagesController < AdminController
    before_action :set_page, only: %i[ show edit update destroy ]

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

      respond_to do |format|
        if @page.save
          format.html { redirect_to admin_page_url(@page), notice: 'Page was successfully created.' }
          format.json { render :show, status: :created, location: @page }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @page.update(page_params)
          format.html { redirect_to admin_page_url(@page), notice: 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: @page }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @page.destroy

      respond_to do |format|
        format.html { redirect_to admin_pages_url, notice: 'Page was successfully destroyed.' }
        format.json { head :no_content }
      end
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
