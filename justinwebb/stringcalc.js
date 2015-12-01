'use strict';

var stringcalc = {
  add: function (str) {
    var sum = 0;
    this.filterNumbers(str).forEach(function (number) {
      sum += number;
    });
    return sum;
  },

  filterNumbers: function (str) {
    var collection = [];
    var digits = '';
    var self = this;
    if (str.length) {
      str.split('').forEach(function (char) {
        if (/[0-9\-]/.test(char)) {
          digits += char;
        } else if (digits !== '') {
          collection = self.collectDigits(digits, collection);
          digits = '';
        }
      });
      collection = this.collectDigits(digits, collection);
    }
    this.validate();
    return collection;
  },

  validate: function () {
    if (this.badNumbers.length) {
      var msg = 'negatives not allowed: '+ this.badNumbers.join(',');
      this.badNumbers = [];
      throw new Error(msg);
    }
  },

  badNumbers: [],

  scanDigits: function (digits) {
    var number = parseInt(digits);

    if (number < 0) {
      this.badNumbers.push(digits);
    } else if (number > 1000){
      number = 0;
    }
    return number;
  },

  collectDigits: function (digits, collection) {
    digits = this.scanDigits(digits);
    collection.push(digits);
    return collection;
  }
};
