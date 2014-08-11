module Backlogg

  module Api

    module V1

      class ProjectsController < ApplicationController

        # Get all projects
        get '/' do
          json Project.all.map { |project| ProjectSerializer.new(project) }
        end

        # Get a specific project
        get '/:id' do
          param :id, Integer, required: true

          project = Project.find_by_id(params[:id])
          halt 404, {errors: true, message: "Project not found"}.to_json unless project

          status 200
          json ProjectSerializer.new(project)
        end

        # Get all sprints for a specific project
        get '/:id/sprints' do
          param :id, Integer, required: true

          project = Project.find_by_id(params[:id])
          halt 404, {errors: true, message: "Project not found"}.to_json unless project

          status 200
          json project.sprints.map { |sprint| SprintSerializer.new(sprint) }
        end

        # Create a new project
        post '/' do
          param :name, String, required: true
          param :user_id, Integer, required: true
          param :code, String, required: true, min_length: 2, max_length: 2

          user = User.find_by_id(params[:user_id])
          halt 404, {errors: true, message: "User not found"}.to_json unless user

          project = Project.create(name: params[:name], code: params[:code], user: user)
          halt 400, {errors: project.errors.messages, message: "Error creating project"}.to_json unless project

          status 200
          json ProjectSerializer.new(project)
        end

        # Update a specific project
        put '/:id' do
          param :id, Integer, required: true

          project = Project.find_by_id(params[:id])
          halt 404, {errors: true, message: "Project not found"}.to_json unless project

          status 200
          project.update(project_params)
        end

        # Delete a specific project
        delete '/:id' do
          param :id, Integer, required: true

          project = Project.find_by_id(params[:id])
          halt 404, {errors: true, message: "Project not found"}.to_json unless project

          status 200
          project.destroy
        end

      end

    end

  end

end