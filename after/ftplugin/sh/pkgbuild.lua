if vim.fn.expand("%:t") == "PKGBUILD" then
  vim.env.SHELLCHECK_OPTS = "--exclude=SC2034,SC2154,SC1090,SC1091,SC2086,SC2164"
end
