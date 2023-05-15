namespace :goods do
  desc "Confirm all unconfirmed goods"
  task confirm: :environment do
    Good.where(confirmed: false).update_all(confirmed: true)
  end
end
