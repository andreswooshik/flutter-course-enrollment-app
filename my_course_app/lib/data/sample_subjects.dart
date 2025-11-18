import '../domain/models/subject.dart';


class SampleSubjects {
  static List<Subject> getFirstYearSubjects() {
    return [
    
      
      Subject(
        id: 'PROG1',
        code: 'PROG-1',
        name: 'Programming 1',
        description: 'Introduction to programming concepts using Python. Covers variables, data types, control structures, functions, and basic algorithms.',
        schedule: 'MWF 8:30-9:30 AM',
        instructor: 'Engr. Carmel Tejana',
        units: 3,
        capacity: 30,
        enrolled: 25,
        type: SubjectType.major,
      ),
      
      Subject(
        id: 'WEBDEV',
        code: 'WEBDEV',
        name: 'Web Development',
        description: 'Introduction to web development. Covers HTML5, CSS3, JavaScript fundamentals, and responsive design principles.',
        schedule: 'TTH 10:30-12:30 PM',
        instructor: 'Prof. Bandalan',
        units: 3,
        capacity: 30,
        enrolled: 30,
        type: SubjectType.major,
      ),
      
      Subject(
        id: 'COMPMATH',
        code: 'COMPMATH',
        name: 'Computing Math Prep',
        description: 'Mathematical foundations for computing. Covers discrete mathematics, logic, sets, relations, functions, and basic algorithms.',
        schedule: 'MWF 1:30-2:30 PM',
        instructor: 'Prof. Leni Robredo',
        units: 3,
        capacity: 30,
        enrolled: 28,
        type: SubjectType.major,
      ),

      Subject(
        id: 'GEMMW',
        code: 'GE-MMW',
        name: 'Mathematics in the Modern World',
        description: 'General Education course covering mathematical concepts and their applications in real-world scenarios, data analysis, and problem-solving.',
        schedule: 'TTH 1:30-2:30 PM',
        instructor: 'Prof. Rodrigo Duterte',
        units: 3,
        capacity: 30,
        enrolled: 28,
        type: SubjectType.minor,
      ),
      
      Subject(
        id: 'REED',
        code: 'REED',
        name: 'Readings in Philippine History',
        description: 'General Education course exploring Philippine history through primary sources, historical texts, and critical readings.',
        schedule: 'MWF 10:30-11:30 AM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 50,
        enrolled: 38,
        type: SubjectType.minor,
      ),

      // Additional 1st Year 1st Semester Courses
      Subject(
        id: 'ICOMP',
        code: 'I-COMP',
        name: 'Introduction to Computing',
        description: 'Fundamental concepts of computing, computer systems, and information technology.',
        schedule: 'TTH 8:30-10:00 AM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 35,
        enrolled: 20,
        type: SubjectType.major,
      ),

      Subject(
        id: 'EP1',
        code: 'EP 1',
        name: 'English Proficiency Level 1 (lec/lab)',
        description: 'Development of English language skills including reading, writing, listening, and speaking.',
        schedule: 'MWF 2:00-3:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 30,
        enrolled: 22,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'REED1',
        code: 'ReEd 1',
        name: 'Initium Fidei: An Introduction to Doing Catholic Theology',
        description: 'Introduction to Catholic theology, faith, and religious education.',
        schedule: 'TTH 1:00-2:30 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 40,
        enrolled: 25,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'PE1',
        code: 'PE 1',
        name: 'Physical Education 1',
        description: 'Physical fitness, health, and wellness activities.',
        schedule: 'F 3:00-5:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 2,
        capacity: 40,
        enrolled: 30,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'CWTS11',
        code: 'CWTS 11*',
        name: 'Civic Welfare Training Services 11',
        description: 'Community service and civic welfare training program.',
        schedule: 'S 8:00-12:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 35,
        enrolled: 28,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'GUIDANCE1',
        code: 'Guidance 1',
        name: 'Adjustment to College Life Phase 1',
        description: 'Orientation and adjustment to college life, study skills, and personal development.',
        schedule: 'M 4:00-5:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 1,
        capacity: 50,
        enrolled: 35,
        type: SubjectType.minor,
      ),

      // 1st Year 2nd Semester Courses
      Subject(
        id: 'DISCRETE1',
        code: 'Discrete 1',
        name: 'Discrete Structures 1',
        description: 'Discrete mathematics including logic, sets, relations, functions, and graph theory.',
        schedule: 'MWF 9:00-10:00 AM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 30,
        enrolled: 18,
        type: SubjectType.major,
      ),

      Subject(
        id: 'PROG2',
        code: 'Prog 2',
        name: 'Computer Programming 2',
        description: 'Advanced programming concepts including object-oriented programming and data structures.',
        schedule: 'TTH 10:00-12:00 PM',
        instructor: 'Engr. Carmel Tejana',
        units: 3,
        capacity: 30,
        enrolled: 20,
        type: SubjectType.major,
      ),

      Subject(
        id: 'DIGITAL',
        code: 'Digital',
        name: 'Digital Logic Design',
        description: 'Digital circuits, logic gates, Boolean algebra, and computer architecture fundamentals.',
        schedule: 'MWF 1:00-2:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 30,
        enrolled: 22,
        type: SubjectType.major,
      ),

      Subject(
        id: 'GERPH',
        code: 'GE RPH',
        name: 'Readings in Philippine History',
        description: 'Study of Philippine history through primary and secondary sources.',
        schedule: 'TTH 2:00-3:30 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 40,
        enrolled: 30,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'EFCOM',
        code: 'EfCom',
        name: 'Effective Communication',
        description: 'Development of effective communication skills for academic and professional contexts.',
        schedule: 'MWF 10:00-11:00 AM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 35,
        enrolled: 25,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'REED2',
        code: 'ReEd 2',
        name: 'Written That You May Believe: An Introduction to Biblical Exegesis',
        description: 'Introduction to biblical interpretation and exegesis.',
        schedule: 'TTH 8:00-9:30 AM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 40,
        enrolled: 28,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'PE2',
        code: 'PE 2',
        name: 'Physical Education 2',
        description: 'Continuation of physical fitness and sports activities.',
        schedule: 'F 1:00-3:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 2,
        capacity: 40,
        enrolled: 32,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'CWTS12',
        code: 'CWTS 12',
        name: 'Civic Welfare Training Services 12',
        description: 'Continuation of community service and civic welfare training.',
        schedule: 'S 8:00-12:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 3,
        capacity: 35,
        enrolled: 30,
        type: SubjectType.minor,
      ),

      Subject(
        id: 'GUIDANCE2',
        code: 'Guidance 2',
        name: 'Adjustment to College Life Phase 2',
        description: 'Continued guidance on college life adjustment and career planning.',
        schedule: 'M 3:00-4:00 PM',
        instructor: 'Prof. Ferdinand Marcos Sr.',
        units: 1,
        capacity: 50,
        enrolled: 38,
        type: SubjectType.minor,
      ),
    ];
  }
  
  
  static List<Subject> getMajorSubjects() {
    return getFirstYearSubjects()
        .where((subject) => subject.type == SubjectType.major)
        .toList();
  }
  

  static List<Subject> getMinorSubjects() {
    return getFirstYearSubjects()
        .where((subject) => subject.type == SubjectType.minor)
        .toList();
  }
}