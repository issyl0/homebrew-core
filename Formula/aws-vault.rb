class AwsVault < Formula
  desc "Securely store and access AWS credentials in development environments"
  homepage "https://github.com/99designs/aws-vault"
  url "https://github.com/99designs/aws-vault/archive/v6.2.0.tar.gz"
  sha256 "39886f4bc3985d4aefbae6fc88532499ac2c39cbabc33d860bba6d355158e17d"
  license "MIT"

  depends_on "go" => :build
  depends_on :linux

  def install
    flags = "-X main.Version=#{version} -s -w"

    system "go", "build", *std_go_args, "-ldflags=#{flags}"

    zsh_completion.install "contrib/completions/zsh/aws-vault.zsh"
    bash_completion.install "contrib/completions/bash/aws-vault.bash"
  end

  test do
    assert_match("aws-vault: error: required argument 'profile' not provided, try --help",
      shell_output("#{bin}/aws-vault login 2>&1", 1))
  end
end
