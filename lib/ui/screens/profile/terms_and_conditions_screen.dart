import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/terms_content.dart';
import 'package:intl/intl.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final String currentDate = DateFormat.yMMMMd().format(DateTime.now());

    final isKhmer = Localizations.localeOf(context).languageCode == 'km';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(t.termOfCondition),
        elevation: 0,
        backgroundColor: colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: _buildTermsView(
        context: context,
        title: isKhmer ? 'លក្ខខណ្ឌប្រើប្រាស់' : 'Terms and Conditions',
        lastUpdated: isKhmer
            ? 'ធ្វើបច្ចុប្បន្នភាពចុងក្រោយ៖ $currentDate'
            : 'Last Updated: $currentDate',
        intro: isKhmer
            ? 'សូមស្វាគមន៍មកកាន់ Domra-Tech។ លក្ខខណ្ឌទាំងនេះគ្រប់គ្រងការចូលប្រើ និងប្រើប្រាស់កម្មវិធីទូរស័ព្ទ Domra-Tech និងសេវាកម្មពាក់ព័ន្ធ។ ដោយប្រើកម្មវិធីនេះ អ្នកយល់ព្រមគោរពតាមលក្ខខណ្ឌទាំងនេះ។ ប្រសិនបើអ្នកមិនយល់ព្រមជាមួយផ្នែកណាមួយនៃលក្ខខណ្ឌទាំងនេះទេ សូមបញ្ឈប់ការប្រើប្រាស់កម្មវិធី។'
            : 'Welcome to Domra-Tech. These Terms and Conditions govern your access to and use of the Domra-Tech mobile application and related services. By using the application, you agree to comply with these terms. If you do not agree with any part of these terms, please discontinue use of the application.',
        sections: isKhmer ? _khmerSections : _englishSections,
      ),
    );
  }

  Widget _buildTermsView({
    required BuildContext context,
    required String title,
    required String lastUpdated,
    required String intro,
    required List<TermsSectionModel> sections,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            lastUpdated,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Text(
            intro,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 24),
          ...sections.map(
            (section) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TermsSection(
                title: section.title,
                content: section.content,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class TermsSectionModel {
  final String title;
  final String content;
  TermsSectionModel({required this.title, required this.content});
}

final List<TermsSectionModel> _englishSections = [
  TermsSectionModel(
    title: '1. Introduction',
    content:
        'Domra-Tech is a mobile application designed to provide standardized Khmer technical terminology related to digital technology and engineering. The platform allows users to search for technical terms, learn definitions, and contribute suggestions for improving the dictionary database.\nThese Terms and Conditions outline the rules and responsibilities for users when accessing and using the Domra-Tech application.',
  ),
  TermsSectionModel(
    title: '2. User Accounts',
    content:
        'Some features of the application require users to create an account.\nUsers agree to:\n• Provide accurate and complete information during registration.\n• Maintain the confidentiality of their account credentials.\n• Be responsible for all activities performed under their account.\nDomra-Tech reserves the right to suspend or terminate accounts that violate these terms or engage in misuse of the system.',
  ),
  TermsSectionModel(
    title: '3. Use of the Application',
    content:
        'Users may use Domra-Tech for educational, informational, and personal learning purposes.\nUsers agree not to:\n• Use the application for illegal or harmful activities.\n• Attempt to disrupt, damage, or interfere with the application’s functionality.\n• Attempt unauthorized access to system data or other user accounts.\nThe application is intended to support learning and knowledge sharing in the field of technology and engineering.',
  ),
  TermsSectionModel(
    title: '4. Search Limitations',
    content:
        'Domra-Tech follows a freemium model:\n• Free users are allowed up to 10 searches within an 8-hour period.\n• Premium subscribers receive unlimited searches and additional features, including offline access.\nThe system automatically tracks search activity to enforce these limits.',
  ),
  TermsSectionModel(
    title: '5. Subscription and Payments',
    content:
        'Domra-Tech offers optional subscription plans that provide enhanced access to the application.\nSubscriptions may include benefits such as:\n• Unlimited search access\n• Offline dictionary access\n• Priority features\nPayments are processed through Bakong digital payment services. By completing a payment, users agree to the subscription terms displayed at the time of purchase.\nDomra-Tech does not store sensitive financial information. Payment processing is handled securely through third-party services.',
  ),
  TermsSectionModel(
    title: '6. User Contributions',
    content:
        'Domra-Tech allows users to contribute by:\n• Suggesting new technical terms\n• Submitting corrections to existing terms\nBy submitting content, users agree that:\n• The contribution is accurate to the best of their knowledge.\n• The content does not violate intellectual property rights.\nDomra-Tech may review, edit, approve, or reject submissions.\nApproved contributions may become part of the public dictionary database.',
  ),
  TermsSectionModel(
    title: '7. Intellectual Property',
    content:
        'All content within the Domra-Tech application, including text, terminology databases, design elements, and software components, is protected by intellectual property laws.\nUsers may not copy, distribute, reproduce, or commercially exploit the content without permission.\nThe purpose of the platform is educational and informational use only.',
  ),
  TermsSectionModel(
    title: '8. Limitation of Liability',
    content:
        'Domra-Tech strives to provide accurate and reliable technical information. However, the application does not guarantee that all definitions or explanations are free from errors.\nThe platform is provided “as is”, and the development team is not responsible for any direct or indirect damages resulting from the use of the application.\nUsers should verify critical technical information through additional sources when necessary.',
  ),
  TermsSectionModel(
    title: '9. Privacy and Data Protection',
    content:
        'Domra-Tech may collect limited user information required for authentication and service functionality. This information is used solely for application operation and service improvement.\nUser data is protected through secure authentication systems and is not shared with third parties without consent, except where required by law.',
  ),
  TermsSectionModel(
    title: '10. Changes to the Terms',
    content:
        'Domra-Tech reserves the right to update or modify these Terms and Conditions at any time. Any changes will be reflected within the application and will become effective immediately after publication.\nUsers are encouraged to review the Terms periodically.',
  ),
  TermsSectionModel(
    title: '11. Contact Information',
    content:
        'If you have questions regarding these Terms and Conditions, please contact the Domra-Tech development team through the application support channel.',
  ),
];

final List<TermsSectionModel> _khmerSections = [
  TermsSectionModel(
    title: '១. សេចក្តីផ្តើម',
    content:
        'Domra-Tech គឺជាកម្មវិធីទូរស័ព្ទដែលត្រូវបានបង្កើតឡើងដើម្បីផ្តល់នូវពាក្យបច្ចេកទេសខ្មែរតាមស្តង់ដារទាក់ទងនឹងបច្ចេកវិទ្យាឌីជីថល និងវិស្វកម្ម។ វេទិកានេះអនុញ្ញាតឱ្យអ្នកប្រើប្រាស់ស្វែងរកពាក្យបច្ចេកទេស សិក្សាពីអត្ថន័យ និងផ្តល់យោបល់ដើម្បីកែលម្អមូលដ្ឋានទិន្នន័យវចនានុក្រម។\nលក្ខខណ្ឌប្រើប្រាស់ទាំងនេះរៀបរាប់ពីច្បាប់ និងការទទួលខុសត្រូវសម្រាប់អ្នកប្រើប្រាស់ពេលចូលប្រើ និងប្រើប្រាស់កម្មវិធី Domra-Tech។',
  ),
  TermsSectionModel(
    title: '២. គណនីអ្នកប្រើប្រាស់',
    content:
        'មុខងារមួយចំនួននៃកម្មវិធីទាមទារឲ្យអ្នកប្រើប្រាស់បង្កើតគណនី។\nអ្នកប្រើប្រាស់យល់ព្រម៖\n• ផ្តល់ព័ត៌មានពិតប្រាកដ និងពេញលេញអំឡុងពេលចុះឈ្មោះ។\n• រក្សាការសម្ងាត់នៃព័ត៌មានលម្អិតគណនីរបស់ពួកគេ។\n• ទទួលខុសត្រូវចំពោះសកម្មភាពទាំងអស់ដែលបានអនុវត្តក្រោមគណនីរបស់ពួកគេ។\nDomra-Tech រក្សាសិទ្ធិក្នុងការផ្អាក ឬបញ្ចប់គណនីដែលបំពានលក្ខខណ្ឌទាំងនេះ ឬចូលរួមក្នុងការប្រើប្រាស់ប្រព័ន្ធខុស។',
  ),
  TermsSectionModel(
    title: '៣. ការប្រើប្រាស់កម្មវិធី',
    content:
        'អ្នកប្រើប្រាស់អាចប្រើប្រាស់ Domra-Tech សម្រាប់គោលបំណងអប់រំ ព័ត៌មាន និងការសិក្សាផ្ទាល់ខ្លួន។\nអ្នកប្រើប្រាស់យល់ព្រមមិន៖\n• ប្រើប្រាស់កម្មវិធីសម្រាប់សកម្មភាពខុសច្បាប់ ឬបង្កគ្រោះថ្នាក់។\n• ប៉ុនប៉ងរំខាន បំផ្លាញ ឬជ្រៀតជ្រែកដល់ដំណើរការកម្មវិធី។\n• ប៉ុនប៉ងដំឡើងការចូលប្រើទិន្នន័យប្រព័ន្ធ ឬគណនីអ្នកប្រើប្រាស់ផ្សេងទៀតដោយគ្មានការអនុញ្ញាត។\nកម្មវិធីនេះមានគោលបំណងគាំទ្រការរៀនសូត្រ និងការចែករំលែកចំណេះដឹងក្នុងវិស័យបច្ចេកវិទ្យា និងវិស្វកម្ម។',
  ),
  TermsSectionModel(
    title: '៤. ដែនកំណត់នៃការស្វែងរក',
    content:
        'Domra-Tech អនុវត្តតាមគំរូ freemium៖\n• អ្នកប្រើប្រាស់ឥតគិតថ្លៃត្រូវបានអនុញ្ញាតឱ្យស្វែងរកត្រឹម ១០ ដងក្នុងរយៈពេល ៨ ម៉ោង។\n• អ្នកជាវពិសេសទទួលបានការស្វែងរកដោយគ្មានកំណត់ និងមុខងារបន្ថែម រួមទាំងការចូលប្រើដោយគ្មានអ៊ីនធឺណិត។\nប្រព័ន្ធតាមដានសកម្មភាពស្វែងរកដោយស្វ័យប្រវត្តិដើម្បីអនុវត្តដែនកំណត់ទាំងនេះ។',
  ),
  TermsSectionModel(
    title: '៥. ការជាវ និងការបង់ប្រាក់',
    content:
        'Domra-Tech ផ្តល់ជូនជម្រើសគម្រោងការជាវដែលផ្តល់ការចូលប្រើប្រសើរជាងមុនទៅកម្មវិធី។\nការជាវអាចរួមបញ្ចូលអត្ថប្រយោជន៍ដូចជា៖\n• ចូលប្រើការស្វែងរកគ្មានកំណត់\n• ចូលប្រើវចនានុក្រមដោយគ្មានអ៊ីនធឺណិត\n• មុខងារអាទិភាព\nការទូទាត់ត្រូវបានដំណើរការតាមរយៈសេវាកម្មទូទាត់ឌីជីថល Bakong។ ដោយបញ្ចប់ការបង់ប្រាក់ អ្នកប្រើប្រាស់យល់ព្រមពីលក្ខខណ្ឌនៃការជាវដែលបង្ហាញនៅពេលទិញ។\nDomra-Tech មិនរក្សាទុកឯកសារហិរញ្ញវត្ថុរសើបទេ។ ការដំណើរការបង់ប្រាក់ត្រូវបានចាត់ចែងដោយសុវត្ថិភាពតាមរយៈសេវាកម្មភាគីទីបី។',
  ),
  TermsSectionModel(
    title: '៦. ការចូលរួមរបស់អ្នកប្រើប្រាស់',
    content:
        'Domra-Tech អនុញ្ញាតឲ្យអ្នកប្រើប្រាស់ចូលរួមដោយ៖\n• ស្នើពាក្យបច្ចេកទេសថ្មីៗ\n• ដាក់ស្នើការកែតម្រូវចំពោះពាក្យដែលមានស្រាប់\nដោយការដាក់ស្នើមាតិកា អ្នកប្រើប្រាស់យល់ព្រមថា៖\n• ការរួមចំណែកគឺត្រឹមត្រូវតាមចំណេះដឹងរបស់ពួកគេ។\n• មាតិកាមិនបំពានលើកម្មសិទ្ធិបញ្ញា។\nDomra-Tech អាចពិនិត្យ កែសម្រួល អនុម័ត ឬច្រានចោលការដាក់ស្នើ។\nការរួមចំណែកដែលបានអនុម័តអាចក្លាយជាផ្នែកមួយនៃមូលដ្ឋានទិន្នន័យវចនានុក្រមសាធារណៈ។',
  ),
  TermsSectionModel(
    title: '៧. កម្មសិទ្ធិបញ្ញា',
    content:
        'មាតិកាទាំងអស់នៅក្នុងកម្មវិធី Domra-Tech រួមទាំងអត្ថបទ មូលដ្ឋានទិន្នន័យពាក្យបច្ចេកទេស ការរចនា និងសមាសភាគកម្មវិធី ត្រូវបានការពារដោយច្បាប់កម្មសិទ្ធិបញ្ញា។\nអ្នកប្រើប្រាស់មិនអាចចម្លង ចែកចាយ ផលិតឡើងវិញ ឬទាញយកផលប្រយោជន៍ពាណិជ្ជកម្មពីមាតិកាដោយគ្មានការអនុញ្ញាត។\nគោលបំណងនៃវេទិកាគឺសម្រាប់តែការប្រើប្រាស់ផ្នែកអប់រំ និងព័ត៌មានប៉ុណ្ណោះ។',
  ),
  TermsSectionModel(
    title: '៨. ការកំណត់នៃការទទួលខុសត្រូវ',
    content:
        'Domra-Tech ខិតខំផ្តល់ព័ត៌មានបច្ចេកទេសដែលត្រឹមត្រូវ និងអាចជឿទុកចិត្តបាន។ ទោះជាយ៉ាងណាក៏ដោយ កម្មវិធីនេះមិនធានាថា រាល់ការកំណត់ន័យ ឬការពន្យល់គឺគ្មានកំហុសទេ។\nវេទិកាត្រូវបានផ្តល់ជូន "ដូចមាន" ហើយក្រុមអ្នកអភិវឌ្ឍមិនទទួលខុសត្រូវចំពោះការខូចខាតដោយផ្ទាល់ ឬដោយប្រយោលដែលបណ្តាលមកពីការប្រើប្រាស់កម្មវិធីនោះទេ។\nអ្នកប្រើប្រាស់ត្រូវផ្ទៀងផ្ទាត់ព័ត៌មានបច្ចេកទេសសំខាន់ៗតាមរយៈប្រភពបន្ថែមនៅពេលចាំបាច់។',
  ),
  TermsSectionModel(
    title: '៩. ភាពឯកជន និងការការពារទិន្នន័យ',
    content:
        'Domra-Tech អាចប្រមូលព័ត៌មានអ្នកប្រើប្រាស់ក្នុងកម្រិតមានកំណត់ ដែលចាំបាច់សម្រាប់ការផ្ទៀងផ្ទាត់ និងដំណើរការសេវាកម្ម។ ព័ត៌មាននេះត្រូវបានប្រើប្រាស់តែសម្រាប់ប្រតិបត្តិការកម្មវិធី និងការកែលម្អសេវាកម្មប៉ុណ្ណោះ។\nទិន្នន័យអ្នកប្រើប្រាស់ត្រូវបានការពារតាមរយៈប្រព័ន្ធផ្ទៀងផ្ទាត់សុវត្ថិភាព និងមិនត្រូវបានចែករំលែកជាមួយភាគីទីបីដោយគ្មានការអនុញ្ញាត លើកលែងតែកន្លែងដែលតម្រូវដោយច្បាប់។',
  ),
  TermsSectionModel(
    title: '១០. ការផ្លាស់ប្តូរលក្ខខណ្ឌ',
    content:
        'Domra-Tech រក្សាសិទ្ធិក្នុងការធ្វើបច្ចុប្បន្នភាព ឬកែប្រែលក្ខខណ្ឌទាំងនេះនៅពេលណាមួយ។ ការផ្លាស់ប្តូរណាមួយនឹងត្រូវបានឆ្លុះបញ្ចាំងនៅក្នុងកម្មវិធី និងចូលជាធរមានភ្លាមៗបន្ទាប់ពីការបោះពុម្ពផ្សាយ។\nអ្នកប្រើប្រាស់ត្រូវបានលើកទឹកចិត្តឲ្យពិនិត្យលក្ខខណ្ឌជាប្រចាំ។',
  ),
  TermsSectionModel(
    title: '១១. ព័ត៌មានទំនាក់ទំនង',
    content:
        'ប្រសិនបើអ្នកមានសំណួរទាក់ទងនឹងលក្ខខណ្ឌទាំងនេះ សូមទាក់ទងក្រុមអភិវឌ្ឍន៍ Domra-Tech តាមរយៈប្រព័ន្ធជំនួយកម្មវិធី។',
  ),
];
