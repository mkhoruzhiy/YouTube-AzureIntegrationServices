#r "Newtonsoft.Json"
#r "Microsoft.Azure.Workflows.Scripting"
using System.Globalization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.Workflows.Scripting;
using Newtonsoft.Json.Linq;

/// <summary>
/// Executes the inline csharp code.
/// </summary>
/// <param name="context">The workflow context.</param>
/// <remarks> This is the entry-point to your code. The function signature should remain unchanged.</remarks>
public static async Task<Results> Run(WorkflowContext context, ILogger log)
{
  JToken triggerOutputs = (await context.GetTriggerResults().ConfigureAwait(false)).Outputs;
  var rawdate = triggerOutputs?["body"]?["date"]?.ToString();

  DateTime parsedDate = DateTime.ParseExact(rawdate, "yyyyMMdd", CultureInfo.InvariantCulture);  

  return new Results
  {
    Date = parsedDate.ToString("yyyy-MM-dd")
  };
}

public class Results
{
  public string Date {get; set;}
}