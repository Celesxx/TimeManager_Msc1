defmodule Tm.SchemaTest do
  use Tm.DataCase

  alias Tm.Schema

  describe "users" do
    alias Tm.Schema.User

    import Tm.SchemaFixtures

    @invalid_attrs %{firstName: nil, lastName: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Schema.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Schema.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{firstName: "some firstName", lastName: "some lastName"}

      assert {:ok, %User{} = user} = Schema.create_user(valid_attrs)
      assert user.firstName == "some firstName"
      assert user.lastName == "some lastName"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{firstName: "some updated firstName", lastName: "some updated lastName"}

      assert {:ok, %User{} = user} = Schema.update_user(user, update_attrs)
      assert user.firstName == "some updated firstName"
      assert user.lastName == "some updated lastName"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_user(user, @invalid_attrs)
      assert user == Schema.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Schema.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Schema.change_user(user)
    end
  end

  describe "tasks" do
    alias Tm.Schema.Task

    import Tm.SchemaFixtures

    @invalid_attrs %{description: nil, status: nil, title: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Schema.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Schema.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{description: "some description", status: "some status", title: "some title"}

      assert {:ok, %Task{} = task} = Schema.create_task(valid_attrs)
      assert task.description == "some description"
      assert task.status == "some status"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{description: "some updated description", status: "some updated status", title: "some updated title"}

      assert {:ok, %Task{} = task} = Schema.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.status == "some updated status"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_task(task, @invalid_attrs)
      assert task == Schema.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Schema.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Schema.change_task(task)
    end
  end
end
