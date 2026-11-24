// Experiment 12: MongoDB CRUD Operations
// Database: college, Collection: students

// 1. Switch to database 'college' and initialize the 'students' collection by dropping any pre-existing collection.
use college;
db.students.drop();

// 2. Insert a single student document into the 'students' collection using insertOne().
db.students.insertOne({
  roll_no: 101,
  name: "Manthan",
  department: "Computer",
  semester: 5,
  gpa: 8.8,
  skills: ["Python", "MongoDB", "C++"],
  address: { city: "Panaji", pincode: 403001 },
  status: "Active"
});

// 3. Insert multiple student documents into the 'students' collection using insertMany().
db.students.insertMany([
  {
    roll_no: 102,
    name: "Shubham",
    department: "Computer",
    semester: 5,
    gpa: 9.2,
    skills: ["Java", "SQL", "Docker"],
    address: { city: "Margao", pincode: 403601 },
    status: "Active"
  },
  {
    roll_no: 103,
    name: "Sparsh",
    department: "IT",
    semester: 5,
    gpa: 7.9,
    skills: ["HTML", "CSS", "JavaScript"],
    address: { city: "Vasco", pincode: 403802 },
    status: "Active"
  },
  {
    roll_no: 104,
    name: "Vibhav",
    department: "Computer",
    semester: 5,
    gpa: 9.8,
    skills: ["Python", "Rust", "MongoDB"],
    address: { city: "Panaji", pincode: 403001 },
    status: "Active"
  }
]);

// 4. Retrieve all student documents from the 'students' collection.
db.students.find();

// 5. Find students belonging to the 'Computer' department with GPA greater than or equal to 9.0 using comparison and equality operators.
db.students.find({
  department: "Computer",
  gpa: { $gte: 9.0 }
});

// 6. Retrieve student records using projection to display only roll_no, name, department, and gpa (excluding _id).
db.students.find({}, { _id: 0, roll_no: 1, name: 1, department: 1, gpa: 1 });

// 7. Query documents matching array element 'MongoDB' and embedded address field city 'Panaji' using dot notation.
db.students.find(
  { skills: "MongoDB", "address.city": "Panaji" },
  { _id: 0, roll_no: 1, name: 1, skills: 1, "address.city": 1 }
);

// 8. Sort students by GPA in descending order and limit the results to the top 2 students using projection.
db.students.find({}, { _id: 0, name: 1, gpa: 1 }).sort({ gpa: -1 }).limit(2);

// 9. Update a single document using updateOne() with $set and $push: update GPA to 8.2 and add skill 'Python' for student 'Sparsh'.
db.students.updateOne(
  { name: "Sparsh" },
  { $set: { gpa: 8.2 }, $push: { skills: "Python" } }
);
db.students.find({ name: "Sparsh" });

// 10. Update multiple documents using updateMany(): add field 'institution' with value 'GEC' for all students in semester 5.
db.students.updateMany(
  { semester: 5 },
  { $set: { institution: "GEC" } }
);
db.students.find({}, { _id: 0, roll_no: 1, name: 1, department: 1, institution: 1 });

// 11. Delete a single student document from the collection using deleteOne() for student 'Sparsh'.
db.students.deleteOne({ name: "Sparsh" });
db.students.find({ name: "Sparsh" });

// 12. Retrieve all remaining student documents from the collection to verify the final database state.
db.students.find({}, { _id: 0, roll_no: 1, name: 1, department: 1, gpa: 1, status: 1, institution: 1 });

