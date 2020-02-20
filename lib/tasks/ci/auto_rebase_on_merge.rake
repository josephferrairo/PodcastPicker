# frozen_string_literal: true

namespace :ci do
  desc "Rebase PRs"
  task :auto_rebase_on_merge, [:github_token] => [:environment] do |_, args|
    github_token = args[:github_token]
    # github_prs_url = "https://api.github.com/repos/getquip/quip/pulls"
    github_prs_url = "https://api.github.com/repos/josephferrairo/podcastpicker/pulls"
    auth_headers = { "Authorization": "token #{github_token}",
                     "User-Agent": "Httparty",
                     "Accept": "application/vnd.github.lydian-preview+json" }

    pull_requests = HTTParty.get(github_prs_url, headers: auth_headers)

    puts pull_requests.count

    pull_request = pull_requests.select { |x| x["number"] == 3252 }.last

    head_ref = pull_request["head"]["ref"]
    base_ref = pull_request["base"]["ref"]
    pr_url = pull_request["url"]

    good_response = HTTParty.put(good_url, headers: auth_headers)

    git_config = %x(
                    git config --global user.email "developers@joeferrairo.com"
                    git config --global user.name "Github Actions"
                   )

    puts git_config

    cl = %x(
              git fetch origin
              git checkout #{head_ref}
              git rebase origin/#{base_ref}
              git push --force-with-lease origin #{head_ref}
      )
    puts "#{pr_url} => #{good_response}"
    puts cl

        pull_requests.each do |pull_request|
          head_ref = pull_request["head"]["ref"]
          base_ref = pull_request["base"]["ref"]
          pr_url = pull_request["url"]

          if head_ref != "master" &&
             head_ref != "production" &&
             !head_ref.include?("release") &&
             !head_ref.include?("hotfix")

            update_branch_url = "#{pr_url}/update-branch"
            puts "Updating #{pr_url}, head: #{head_ref}, base: #{base_ref}"
            response = HTTParty.put(update_branch_url, headers: auth_headers)
            http_status = response.headers["status"]

            if http_status == "202 Accepted"
            cl = %x(
                git fetch origin
                git checkout #{head_ref}
                git rebase origin/#{base_ref}
                git push --force-with-lease origin #{head_ref}
               )
              puts "#{pr_url} => #{response}"
            end

          else
            puts "#{pr_url} with head_ref: #{head_ref} will not be updated with latest #{base_ref}"
          end
    end
  end
end
