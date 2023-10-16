import unittest

from whiteboard import solution

class MatchTestCase(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(solution([0,1,0,3,12]), [1,3,12,0,0])
    def test_example_two(self):
        self.assertEqual(solution([0,0,11,2,3,4]), [11,2,3,4,0,0])
    def test_no_zero(self):
        self.assertEqual(solution([1,2,3,4,5]), [1,2,3,4,5])
    def test_multi(self):
        self.assertEqual(solution([10,20,30,0,90,0,11]), [10,20,30,90,11,0,0])
    def test_all_but_one(self):
        self.assertEqual(solution([0,0,0,0,0,0,1]),[1,0,0,0,0,0,0])


if __name__ == '__main__':
    unittest.main()