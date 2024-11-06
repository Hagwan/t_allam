import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final PoemGenerator _generator = PoemGenerator();
  Future<String>? _storyText;

  void _generateStory(String choice) {
    setState(() {
      _storyText = _generator.generateStories(choice);
    });
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
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.withOpacity(0.2),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.withOpacity(0.4),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('lib/assets/images/Allam_head.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                height: 200,
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
                          label: 'قصة',
                          onPressed: () =>
                              _generateStory('قصة عن مملكة الحيوانات')),
                      const SizedBox(width: 16),
                      OptionButton(
                          label: 'أ', onPressed: () => _generateStory('أ')),
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
      "input": """<s> $word <<SYS>>


### *التعليمات (Set up Instructions)*:

1. *البداية*:
   - يبدأ الطفل بإدخال عنوان للقصة.
   - يقوم الذكاء الاصطناعي بإنشاء مقدمة للقصة بناءً على العنوان المُعطى ويقدم خيارين بسيطين للطفل.

2. *التفاعل القائم على الاختيارات*:
   - بعد كل جزء من القصة، يقدم الذكاء الاصطناعي خيارين جديدين للطفل.
   - تستمر القصة بناءً على اختيارات الطفل، وتستمر التفاعلات حتى الوصول إلى الرد العاشر.

3. *نهاية القصة*:
   - عند الرد العاشر، يتم إنهاء القصة بنهاية جميلة وسلمية، وتشجيع الطفل على بدء مغامرة جديدة أو الانتهاء.

4. *التفاعل المخصص*:
   - الردود يجب أن تكون مصممة بشكل تفاعلي وإبداعي للأطفال، مع المحافظة على عنصر التسلية والإثارة.

---

### *التعليمات (Execution Instructions)*:

1. *البداية الفورية*:
   - ابدأ القصة مباشرة بعد إدخال العنوان بدون تحية أو مقدمات إضافية.

2. *التفاعل مع الخيارات*:
   - بعد كل جزء من القصة، يقدم الذكاء الاصطناعي خيارين (أ أو ب). بعد تقديم الخيارين، يتوقف الإخراج دون متابعة القصة حتى يتم اختيار أحد الخيارين.
you must not say {
يرجى اختيار الخيار (أ) أو (ب) لبدء مغامرتك.

(ملاحظة: سأقوم بتوليد القصة بناءً على اختيارك والتفاعل معك بناءً على الخيارات المقدمة)

إذا كنت ترغب في قصة مختلفة أو تحتاج مساعدة إضافية، يرجى إعلامي.}

3. *نهاية القصة بعد 10 خيارات*:
   - بعد 10 اختيارات من الطفل، يجب أن تنتهي القصة بشكل جميل وسلمي.

4. *اللغة الشاملة*:
   - استخدم لغة عامة وشاملة لجميع الأطفال دون تحديد الجنس.

---

### *مثال القصة (Story Example)*:

#### *المدخل الأول (Input 1)*:
 
عنوان القصة: \"رحلة البحث عن التنين المفقود\"


#### *الإخراج الأول (Output 1)*:
 
في يوم من الأيام، في عالم مليء بالجبال العالية والسحب البيضاء، قررت أن تبدأ رحلة للبحث عن التنين المفقود، الذي اختفى منذ زمن طويل.

أ) هل تريد أن تبدأ الرحلة بالسفر إلى الجبال العالية؟  
ب) أم ترغب في البحث في الغابة المظلمة حيث شوهد التنين آخر مرة؟


---

#### *المدخل الثاني (Input 2)*:
 
أ) السفر إلى الجبال العالية.


#### *الإخراج الثاني (Output 2)*:
 
تتسلق الجبال العالية وتجد نفسك وسط السحب البيضاء، البرد يلفح وجهك والرياح تعصف من حولك. فجأة، ترى كهفًا كبيرًا محفورًا في الجبل.

أ) هل تدخل الكهف لاستكشافه؟  
ب) أم تواصل التسلق إلى القمة؟


---

#### *المدخل الثالث (Input 3)*:
 
أ) أدخل الكهف لاستكشافه.


#### *الإخراج الثالث (Output 3)*:
 
تدخل الكهف وتسمع صوت قطرات الماء وهي تتساقط من السقف. الجو بارد وغامض، ولكنك تلاحظ آثار أقدام كبيرة على الأرض. هل يمكن أن تكون هذه آثار التنين؟

أ) هل تتبع آثار الأقدام؟  
ب) أم تبحث عن مكان آخر داخل الكهف؟


---

#### *المدخل الرابع (Input 4)*:
 
أ) أتبَع آثار الأقدام.


#### *الإخراج الرابع (Output 4)*:
 
أنت تتبع آثار الأقدام ببطء، وكلما تقدمت أكثر، تلاحظ أن الأثر يصبح أعمق وأكبر. فجأة، تجد ممرًا ضيقًا يؤدي إلى غرفة مظلمة.

أ) هل تدخل الغرفة المظلمة؟  
ب) أم تعود إلى مدخل الكهف؟


---

#### *المدخل الخامس (Input 5)*:
 
أ) أدخل الغرفة المظلمة.


#### *الإخراج الخامس (Output 5)*:
 
عندما تدخل الغرفة المظلمة، تضاء بنور أزرق ساطع من حجر كبير في الوسط. يبدو أن هذا الحجر هو قلب الكهف. تجد نقشًا قديمًا على الجدار يشير إلى التنين المفقود.

أ) هل تلمس الحجر لتكتشف سر التنين؟  
ب) أم تقرر الخروج من الغرفة؟


---

#### *المدخل السادس (Input 6)*:
 
أ) ألامس الحجر لاكتشاف سر التنين.


#### *الإخراج السادس (Output 6)*:
 
بمجرد أن تلمس الحجر، تشعر بقوة غريبة تسري في جسدك. الحجر يبدأ في التوهج أكثر وأكثر، وفجأة تسمع صوتًا هادئًا يقول: \"التنين المفقود قريب، لكنه يختبئ في مكان لا تتوقعه.\"

أ) هل تبحث في الكهف أكثر؟  
ب) أم تخرج وتبحث في الجبال المحيطة؟


---

#### *المدخل السابع (Input 7)*:
 
ب) أخرج وأبحث في الجبال المحيطة.


#### *الإخراج السابع (Output 7)*:
 
تخرج من الكهف وتواصل التسلق في الجبال المحيطة. بينما تمشي بين الصخور، تشعر باهتزاز طفيف تحت قدميك. الأرض تهتز بشكل غريب.

أ) هل تحفر في المكان الذي يهتز؟  
ب) أم تبتعد بحثًا عن مكان آخر؟


---

#### *المدخل الثامن (Input 8)*:
 
أ) أحفر في المكان الذي يهتز.


#### *الإخراج الثامن (Output 8)*:
 
أنت تبدأ في الحفر وتكتشف مدخلًا سريًا تحت الصخور. يبدو أن التنين قد استخدمه للاختباء. تدخل المدخل لتجد نفقًا طويلًا يؤدي إلى غرفة تحت الأرض.

أ) هل تدخل الغرفة السرية؟  
ب) أم تقرر أن تعود وتبحث في مكان آخر؟


---

#### *المدخل التاسع (Input 9)*:
 
أ) أدخل الغرفة السرية.


#### *الإخراج التاسع (Output 9)*:
 
داخل الغرفة السرية، ترى تنينًا ضخمًا ولكنه مسالم. التنين ينظر إليك بعينين لامعتين ويقول: \"لقد كنت في انتظارك. أنت الشخص الذي سيعيد السلام لهذا العالم.\"

أ) هل تتحدث مع التنين لاكتشاف ما يقصده؟  
ب) أم تخرج من الغرفة لتعود إلى العالم الخارجي؟


---

#### *المدخل العاشر (Input 10)*:
 
أ) أتحدث مع التنين لأكتشف ما يقصده.


#### *الإخراج العاشر (Output 10)*:
 
تقترب من التنين وتستمع إليه وهو يخبرك بسر كبير: \"السلام الحقيقي يأتي من التفاهم والصداقة. لقد انتظرت طويلًا شخصًا يستمع إلى هذا الدرس.\" بعد حديث طويل مع التنين، تشعر بالسلام في داخلك وتقرر العودة إلى العالم لتشارك حكمته مع الجميع.

وهكذا انتهت مغامرتك، وقد وجدت التنين المفقود وعرفت سر السلام. هل ترغب في بدء مغامرة جديدة أم العودة إلى القائمة الرئيسية؟

<</SYS>>
Output:""",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 900,
        "stop_sequences": ["مغامرتك"],
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
