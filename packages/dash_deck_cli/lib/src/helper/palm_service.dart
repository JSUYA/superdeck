import 'package:dash_deck_cli/env/env.dart';
import 'package:dash_deck_cli/src/helper/prompts/dto/prompt_data.dto.dart';
import 'package:palm_api/palm_api.dart';

final _palm = TextService(apiKey: Env.palmApiKey);

class PalmService {
  Future<GenerateTextResponse?> generateTextWithPrompt(PromptData data) async {
    return _palm.generateText(
      data.modelName,
      GenerateTextRequest(
        prompt: TextPrompt(text: data.prompt),
        candidateCount: data.candidateCount,
        maxOutputTokens: data.maxOutputTokens,
        stopSequences: data.stopSequences,
        safetySettings: data.safetySettings,
        temperature: data.temperature,
        topK: data.topK,
        topP: data.topP,
      ),
    );
  }
}
