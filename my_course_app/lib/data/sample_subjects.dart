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