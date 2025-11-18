#r "Newtonsoft.Json"
#r "Microsoft.Azure.Workflows.Scripting"
using Microsoft.Azure.Workflows;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.Workflows.Scripting;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;

public static async Task<Results> Run(WorkflowContext context, ILogger log)
{
    JToken triggerOutputs = (await context.GetTriggerResults().ConfigureAwait(false)).Outputs;
    var sensitiveText = triggerOutputs?["body"]?["sensitiveText"]?.ToString();

    return new Results
    {
        Text = System.Text.RegularExpressions.Regex.Replace(sensitiveText, @"\b\d{12,16}\b", m => new string('*', m.Length))
    };
}

public class Results
{
    public string Text { get; set; }
}
