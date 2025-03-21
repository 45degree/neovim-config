return function(opts)
  opts.settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
        autoImportCompletions = true,
        diagnosticSeverityOverrides = {
          reportUnusedImport = 'information',
          reportUnusedFunction = 'information',
          reportUnusedVariable = 'information',
          reportGeneralTypeIssues = 'none',
          reportOptionalMemberAccess = 'none',
          reportOptionalSubscript = 'none',
          reportPrivateImportUsage = 'none',
        },
      },
    },
  }
  return opts
end
