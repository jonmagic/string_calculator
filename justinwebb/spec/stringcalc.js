/* global stringcalc, describe, it, expect, should */

describe('stringcalc()', function () {
  'use strict';

  var check = function (expr, result) {
    it('should evaluate '+ expr +' to '+ result,
      function () {
        expect(stringcalc.add(expr)).to.equal(result);
      });
  };

  // Add more assertions here
  describe('basic functionality', function () {
    check('', 0);
    check('1', 1);
    check('1,2', 3);
    check('1,2,3,4,5', 15);
  });

  describe('new lines between numbers', function () {
    check('1\n2,3', 6);
  });

  describe('support different delimiters', function () {
    check('//;\n1;2', 3);
    check('//[***]\n1***2***3', 6);
    check('//[*][%]\n1*2%3', 6);
    check('//[***][%%%]\n1***2%%%3', 6);
  });

  describe('negatives not allowed', function () {
    it('should throw an exception "negatives not allowed"',
      function () {
        expect(stringcalc.add.bind(stringcalc, '-4'))
          .to.throw('negatives not allowed: -4');
      });
    it('should list all negative numbers in error output',
      function () {
        expect(stringcalc.add.bind(stringcalc, '-1,2,-3,4,-5'))
          .to.throw('negatives not allowed: -1,-3,-5');
      });
  });

  describe('bigger than 1000 should be ignored', function () {
    check('1001,2', 2);
  });
});
