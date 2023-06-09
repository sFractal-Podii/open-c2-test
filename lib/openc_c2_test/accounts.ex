defmodule OpencC2Test.Accounts do
  alias OpencC2Test.Accounts.User
  alias OpencC2Test.Repo

  def create_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(email) do
    User
    |> Repo.get_by(email: email)
  end
end
