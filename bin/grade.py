# Grader

# Class for submissions
class Submission():
    def __init__(self, document):
        self.document = document

    def setQA(document):
        QA = getQA(document)

    def getQA(document):
        QA = {}
        question_number = 1
        next_question_number = 2
        while (document.match("/{question_number}.*{next_question_number}/") == True)):
            question_and_answer = document.match("/{question_number}.*{next_question_number}/")
            QA[[question_number]] = question_and_answer
        return QA

    def GetAnswerList(document):
        for answer in document:
            print("\n------------\nDOCUMENT:\n\n{document}\n--------------\n")
            


# Variables to Store Answer Context
student_submission=
correct_submission=
