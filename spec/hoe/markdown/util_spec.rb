RSpec.describe Hoe::Markdown::Util do
  describe "#linkify_github_issues" do
    let(:issues_uri) { "https://example.com/username/projectname/issues" }

    context "issue mentions" do
      it "linkifies issue mentions" do
        markdown = <<~MD
          leading
          how about issues #1, #23,#456?
          trailing
        MD

        expected = <<~MD
          leading
          how about issues [#1](https://example.com/username/projectname/issues/1), [#23](https://example.com/username/projectname/issues/23),[#456](https://example.com/username/projectname/issues/456)?
          trailing
        MD

        actual = Hoe::Markdown::Util.linkify_github_issues(markdown, issues_uri)
        expect(actual).to eq(expected)
      end

      it "does not linkify issue mentions already in a markdown hyperlink" do
        markdown = <<~MD
          leading
          how about issues [#1](https://example.com), [#23](asdf),[#456][]?
          trailing
        MD

        actual = Hoe::Markdown::Util.linkify_github_issues(markdown, issues_uri)
        expect(actual).to eq(markdown)
      end
    end

    context "issue URIs" do
      it "linkifies issue URIs" do
        markdown = <<~MD
          leading
          have you seen https://example.com/username/projectname/issues/23?
          unrelated to https://other.example.com/username/projectname/issues/23, though.
          trailing
        MD

        expected = <<~MD
          leading
          have you seen [#23](https://example.com/username/projectname/issues/23)?
          unrelated to https://other.example.com/username/projectname/issues/23, though.
          trailing
        MD

        actual = Hoe::Markdown::Util.linkify_github_issues(markdown, issues_uri)
        expect(actual).to eq(expected)
      end

      it "does not linkify issue URIs already in a markdown hyperlink" do
        markdown = <<~MD
          leading
          have you seen [this issue](https://example.com/username/projectname/issues/23)?
          trailing
        MD

        actual = Hoe::Markdown::Util.linkify_github_issues(markdown, issues_uri)
        expect(actual).to eq(markdown)
      end
    end

    context "PR URIs" do
      it "linkifies pull request URIs" do
        markdown = <<~MD
          leading
          have you seen https://example.com/username/projectname/pull/23?
          unrelated to https://other.example.com/username/projectname/pull/23, though.
          trailing
        MD

        expected = <<~MD
          leading
          have you seen [#23](https://example.com/username/projectname/pull/23)?
          unrelated to https://other.example.com/username/projectname/pull/23, though.
          trailing
        MD

        actual = Hoe::Markdown::Util.linkify_github_issues(markdown, issues_uri)
        expect(actual).to eq(expected)
      end

      it "does not linkify pull request URIs already in a markdown hyperlink" do
        markdown = <<~MD
          leading
          have you seen [this pull request](https://example.com/username/projectname/pull/23)?
          trailing
        MD

        actual = Hoe::Markdown::Util.linkify_github_issues(markdown, issues_uri)
        expect(actual).to eq(markdown)
      end
    end
  end

  describe "#linkify_github_usernames" do
    it "linkifies usernames" do
      markdown = <<~MD
        leading
        foo @flavorjones and @asdfqwer bar
        foo @y-yagi bar
        trailing
      MD

      expected = <<~MD
        leading
        foo [@flavorjones](https://github.com/flavorjones) and [@asdfqwer](https://github.com/asdfqwer) bar
        foo [@y-yagi](https://github.com/y-yagi) bar
        trailing
      MD

      expect(Hoe::Markdown::Util.linkify_github_usernames(markdown)).to eq(expected)
    end

    it "does not linkify usernames that are already in a markdown hyperlink" do
      markdown = <<~MD
        leading
        don't you know [@flavorjones](https://mike.daless.io/)?
        how about [@asdfqwer][]?
        or [@y-yagi](https://github.com/y-yagi)?
        trailing
      MD

      expect(Hoe::Markdown::Util.linkify_github_usernames(markdown)).to eq(markdown)
    end

    it "does not linkify email addresses" do
      markdown = <<~MD
        leading
        the project email list if loofah-talk@googlegroups.com so ping me there
        my github username is @flavorjones if you need it
        trailing
      MD

      expected = <<~MD
        leading
        the project email list if loofah-talk@googlegroups.com so ping me there
        my github username is [@flavorjones](https://github.com/flavorjones) if you need it
        trailing
      MD

      expect(Hoe::Markdown::Util.linkify_github_usernames(markdown)).to eq(expected)
    end
  end
end
