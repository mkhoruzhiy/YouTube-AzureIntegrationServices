#r "Newtonsoft.Json"
#r "Microsoft.Azure.Workflows.Scripting"
#r "System.Linq"
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.Workflows.Scripting;
using Newtonsoft.Json.Linq;
using System.Linq;

/// <summary>
/// Executes the inline csharp code.
/// </summary>
/// <param name="context">The workflow context.</param>
/// <remarks> This is the entry-point to your code. The function signature should remain unchanged.</remarks>
public static async Task<Results> Run(WorkflowContext context, ILogger log)
{
  JToken triggerOutputs = (await context.GetTriggerResults().ConfigureAwait(false)).Outputs;

  var text = triggerOutputs?["body"]?["text"].ToString();
  var matches = System.Text.RegularExpressions.Regex.Matches(text, @"[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}");

  return new Results
  {
    Emails = matches.Select(m => m.Value).ToArray()
  };
}

public class Results
{
  public string[] Emails {get; set;}
}