


class SumFuntion{


  static List <int> total = [];


  static  int grandTotal (){

      var sum = 0;
      var given_list = total;

      for (var i = 0; i < given_list.length; i++) {
        sum += given_list[i];
      }

      print("Sum : ${sum}");

      return sum;
    }
  }
