#r "Newtonsoft.Json"
#r "Microsoft.Azure.Workflows.Scripting"
#r "System.Security.Cryptography"
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

  var text = triggerOutputs?["body"]?["text"]?.ToString();

  var output = string.Empty;
  using(var sha = System.Security.Cryptography.SHA256.Create())
  {
    var bytes = System.Text.Encoding.UTF8.GetBytes(text);
    var hash = sha.ComputeHash(bytes);
    output = BitConverter.ToString(hash).Replace("-", "").ToLower();
  }

  return new Results
  {
    Hash = output
  };
}

public class Results
{
  public string Hash {get; set;}
}