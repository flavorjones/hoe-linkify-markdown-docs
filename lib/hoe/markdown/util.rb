class Hoe
  module Markdown
    module Util
      GITHUB_ISSUE_MENTION_REGEX = %r{
        # issue number, like '#1234'
        \#([[:digit:]]+)

        # not already in a markdown hyperlink
        (?!\][\(\[])

        # don't truncate the issue number to meet the previous negative lookahead
        (?![[[:digit:]]])
      }x

      # see https://github.com/shinnn/github-username-regex
      GITHUB_USER_REGEX = %r{
        # username, like "@flavorjones"
        @([[:alnum:]](?:[[:alnum:]]|-(?=[[:alnum:]])){0,38})

        # not already in a markdown hyperlink
        (?!\][\(\[])

        # don't truncate the username to meet the previous negative lookahead
        (?![[[:alnum:]]])
      }x

      def self.linkify_github_issues(markdown, issues_uri)
        if issues_uri.nil? || issues_uri.empty?
          raise "#{__FILE__}:#{__method__}: URI for bugs cannot be empty\n"
        end

        issue_uri_regex = %r{
          # not already in a markdown hyperlink
          (?<!\]\()

          #{issues_uri}/([[:digit:]]+)

          # don't truncate the issue number to meet the previous negative lookahead
          (?![[[:digit:]]])
        }x

        pull_uri = issues_uri.gsub("issues", "pull")
        pull_uri_regex = %r{
          # not already in a markdown hyperlink
          (?<!\]\()

          #{pull_uri}/([[:digit:]]+)

          # don't truncate the issue number to meet the previous negative lookahead
          (?![[[:digit:]]])
        }x

        markdown
          .gsub(GITHUB_ISSUE_MENTION_REGEX, "[#\\1](#{issues_uri}/\\1)")
          .gsub(issue_uri_regex, "[#\\1](#{issues_uri}/\\1)")
          .gsub(pull_uri_regex, "[#\\1](#{pull_uri}/\\1)")
      end

      def self.linkify_github_usernames(markdown)
        markdown.gsub(GITHUB_USER_REGEX, "[@\\1](https://github.com/\\1)")
      end
    end
  end
end
