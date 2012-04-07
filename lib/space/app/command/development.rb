module Space
  class App
    class Command
      class Local < Command
        def run
          Shell::Watcher.suspend do
            repos.each do |repo|
              system "bundle config --global local.#{repo.name} #{repo.path}"
            end
            confirm
          end
          project.bundler.refresh
        end
      end

      class Remote < Command
        def run
          Shell::Watcher.suspend do
            repos.each do |repo|
              system "bundle config --delete local.#{repo.name}"
            end
            confirm
          end
          project.bundler.refresh
        end
      end

      # class Install < Command
      #   def run
      #     in_scope do |repo|
      #       repo.execute 'bundle install'
      #       repo.refresh
      #     end
      #   end
      # end

      # class Update < Command
      #   def run
      #     in_scope do |repo|
      #       repo.execute 'bundle update'
      #       repo.execute 'git commit -am "bump dependencies"'
      #       repo.refresh
      #     end
      #   end
      # end

      # class Checkout < Command
      #   def run
      #     # check if branch exists, git co (-b)
      #   end
      # end

      # class PullDeps < Command
      #   def run
      #     # pull all dependencies
      #   end
      # end
    end
  end
end
