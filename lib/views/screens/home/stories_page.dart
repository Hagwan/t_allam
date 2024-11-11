import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:t_allam/models/speech_model.dart'; // Import the ArabicAlphabetModel class
import 'dart:typed_data';

class StoriesScreen extends StatefulWidget {
  final String title; // Add title parameter

  const StoriesScreen({required this.title, Key? key}) : super(key: key);

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final PoemGenerator _generator = PoemGenerator();
  final ArabicAlphabetModel _speechModel = ArabicAlphabetModel();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<String>? _storyText;
  int choiceCounter = 0; // Counter to track the number of choices

  void initState() {
    super.initState();
    // Initialize _storyText with the title as the first prompt
    _storyText = Future.value(widget.title);
    _generateStory(widget.title);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _generateStory(String choice) {
    setState(() {
      choiceCounter++; // Increment the counter on each choice
      print(choiceCounter);

      // Check if this is the fifth choice
      if (choiceCounter == 5) {
        choice +=
            " + إنهاء"; // Append + إنهاء to the choice on the fifth selection
      }

      _storyText = _generator.generateStories(choice);
      print(choice);
    });
  }

  Future<void> _playStoryText() async {
    // Ensure there is text to play
    if (_storyText != null) {
      final storyText = await _storyText; // Retrieve the current story text
      if (storyText != null && storyText.isNotEmpty) {
        final Uint8List? audioData =
            (await _speechModel.speakText(storyText)) as Uint8List?;
        if (audioData != null) {
          await _audioPlayer.play(BytesSource(audioData));
        } else {
          print("Audio generation failed.");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFF6667),
          image: DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.withOpacity(0.7),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.withOpacity(0.5),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('lib/assets/images/Allam_head.png'),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.blue, size: 30),
                onPressed: _playStoryText, // Play story text as speech
              ),
              Container(
                padding: const EdgeInsets.all(16),
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: FutureBuilder<String>(
                  future: _storyText,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text('Error loading story');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(
                        'أسمي علام وسأساعدك في تعلم القصص. اتبع التعليمات واستمتع بالرحلة التعليمية!',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      );
                    }
                    return SingleChildScrollView(
                      child: Text(
                        snapshot.data!,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  const Text(
                    'اختر من هنا',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionButton(
                          label: 'أ', onPressed: () => _generateStory('أ')),
                      const SizedBox(width: 16),
                      OptionButton(
                          label: 'ب', onPressed: () => _generateStory('ب')),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    // Navigate to the next page or perform action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OptionButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

class PoemGenerator {
  final String apiKey = dotenv.env['API_KEY']!;
  final String tokenUrl = 'https://iam.cloud.ibm.com/identity/token';
  final String generateUrl =
      'https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29';

  Future<String> getIbMToken() async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
      'apikey': apiKey,
    };

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final resFormat = json.decode(response.body);
      return resFormat['access_token'];
    } else {
      throw Exception('Error: ${response.statusCode}\n${response.body}');
    }
  }

  Future<String> generateStories(String word) async {
    final token = await getIbMToken();

    final body = {
      "input": """
يجب على الذكاء الاصطناعي أن يبدأ قصة سحرية مختلفة تمامًا بعد انتهاء كل قصة، وذلك عند اختيار الطفل للإنهاء (مثلًا \"أ + إنهاء\" أو \"ب + إنهاء\").


بمجرد إدخال عنوان القصة \"قصة سحرية\"، يبدأ الذكاء الاصطناعي بتقديم مغامرة سحرية جديدة. يختلف كل سرد عن السابق، مما يجعل القصة فريدة في كل مرة، مع تقديم خيارين للطفل للاختيار بينهما.



بعد اختيار الطفل (أ) أو (ب)، يستمر الذكاء الاصطناعي بتقديم جزء جديد من القصة بناءً على الاختيار، مع تقديم خيارين جديدين في كل مرة.

عندما يصل الطفل إلى النقطة الأخيرة ويرسل \"أ + إنهاء\" أو \"ب + إنهاء\"، يقدم الذكاء الاصطناعي نهاية سلمية وملهمة للقصة. بمجرد الانتهاء، يكون الذكاء الاصطناعي جاهزًا لبدء قصة جديدة تمامًا ومختلفة عند الطلب.

التعليمات الأساسية:

ابدأ القصة بمقدمة فريدة بناءً على العنوان \"قصة سحرية\" مع سرد جديد في كل مرة.
قدم خيارين (أ) و(ب) بعد كل جزء، وتابع بناءً على اختيار الطفل.
ابدأ قصة جديدة تلقائيًا بعد انتهاء القصة السابقة إذا اختار الطفل ذلك.

Input: قصة سحرية
Output: في يوم من الأيام، تجد نفسك أمام غابة مليئة بالأشجار المتلألئة والمخلوقات الغريبة. تشعر بأن هناك سرًا كبيرًا داخل هذه الغابة.

أ) هل تدخل الغابة لاستكشافها؟
ب) أم تذهب إلى النهر القريب حيث يُقال إن هناك بوابة سحرية!

Input: أ
Output: عندما تدخل الغابة، تبدأ في رؤية أضواء غامضة تلمع بين الأشجار. تسمع صوتًا ناعمًا يدعوك للقدوم.

أ) هل تتبع الأضواء لمعرفة مصدر الصوت؟
ب) أم تبحث عن مكان مرتفع لتراقب الغابة من الأعلى!

Input: أ
Output: تتبع الأضواء حتى تصل إلى شجرة عملاقة ينبعث منها نور أزرق ساطع. تكتشف أن هناك كائنًا سحريًا ينتظرك بجانب الشجرة.

أ) هل تتحدث مع الكائن السحري لتعرف المزيد عن الغابة؟
ب) أم تستمر في استكشاف الغابة لوحدك!

Input: أ + إنهاء
Output: تحدث مع الكائن السحري وتكتشف أنه يحرس كنزًا من الحكمة في قلب الغابة. بعد محادثة طويلة، تشعر بالسلام والراحة، وتقرر العودة إلى عالمك حاملاً درسًا جديدًا عن الشجاعة.

هل ترغب في بدء مغامرة جديدة أم العودة إلى القائمة الرئيسية!

Input: قصة سحرية
Output: في يوم من الأيام، تجد نفسك أمام قصر قديم محاط بحديقة مليئة بالأزهار المتكلمة. يبدو أن القصر يخفي سرًا كبيرًا.

أ) هل تدخل القصر لاستكشافه؟
ب) أم تذهب إلى الحديقة للتحدث مع الأزهار المتكلمة!


Input: ب
Output: عندما تقترب من الأزهار، تبدأ في التحدث إليك بلغة غامضة وتدلك على مسار يؤدي إلى بوابة سحرية.

أ) هل تتبع المسار للوصول إلى البوابة السحرية؟
ب) أم تبحث عن سر الأزهار في مكان آخر من الحديقة!

Input: ب
Output: أثناء استكشافك لبقية الحديقة، تجد شجرة ضخمة تبدو وكأنها تحتفظ بذكريات قديمة. تُخبرك الأزهار أن هذه الشجرة هي \"شجرة الحكماء\".

أ) هل تقترب من الشجرة للتعلم من حكمتها؟
ب) أم تواصل البحث عن الأسرار في الحديقة!

Input: ب + إنهاء
Output: تقترب من \"شجرة الحكماء\" وتستمع إلى نصائحها. تكتشف أن الحكمة تأتي من التجارب والمغامرات. تشعر بسلام داخلي وتقرر العودة إلى عالمك حاملاً درسًا عن أهمية المعرفة.

هل ترغب في بدء مغامرة جديدة أم العودة إلى القائمة الرئيسية!


Input: $word
Output:""",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 200,
        "stop_sequences": ["!"],
        "repetition_penalty": 1
      },
      "model_id": "sdaia/allam-1-13b-instruct",
      "project_id": "10ee99ea-e10e-49f6-8126-1ac689449710"
    };

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(
      Uri.parse(generateUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return data['results'][0]['generated_text'].trim();
    } else {
      throw Exception('Failed to generate story: ${response.body}');
    }
  }
}
