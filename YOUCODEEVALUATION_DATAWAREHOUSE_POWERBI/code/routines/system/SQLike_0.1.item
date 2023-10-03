// ============================================================================
//
// %GENERATED_LICENSE%
//
// ============================================================================
package routines;

public class SQLike {

    /**
     * get the part of String, reference MySQL: mid
     * 
     * {talendTypes} String
     * 
     * {Category} SQLike
     * 
     * {param} string(sourceString) inStr : inputting String
     * 
     * {param} int(startLocation) beginIndex : the location where to start, if it is negative, just count from tail
     * 
     * {example} mid(",1,2,3,4,", 3) # ",2,3,4,"
     * 
     * {example} mid(",1,2,3,4,", -3) # ",4,"
     */
    public static String mid(String inStr, int beginIndex) {
        if (inStr == null || "".equals(inStr)) {
            return "";
        }
        return mid(inStr, beginIndex, inStr.length());
    }

    /**
     * get the part of String, reference MySQL: mid
     * 
     * {talendTypes} String
     * 
     * {Category} SQLike
     * 
     * {param} string(sourceString) inStr : inputting String
     * 
     * {param} int(startLocation) beginIndex : the location where to start, if it is negative, just count from tail
     * 
     * {param} int(characterCount) count : number of returning chars. if bigger than length of String, will get the part
     * from beginIndex to tail-end
     * 
     * {example} mid(",1,2,3,4,", 3, 2) # ",2"
     * 
     * {example} mid(",1,2,3,4,", -3, 2) # ",4"
     */

    public static String mid(String inStr, int beginIndex, int count) {
        if (inStr == null || "".equals(inStr)) {
            return "";
        }

        int len = inStr.length();
        int absBeginIndex = Math.abs(beginIndex);

        if (beginIndex == 0 || absBeginIndex > len || count <= 0) {
            return "";
        }

        int start = 0, end = 0;

        if (beginIndex > 0) {
            start = beginIndex - 1;
        } else {
            start = len - absBeginIndex;
        }
        end = start + count;

        if (end > len)
            end = len;
        return inStr.substring(start, end);
    }

    /**
     * get the part of String by specify the delimiter, reference MySQL: substring_index
     * 
     * {talendTypes} String
     * 
     * {Category} SQLike
     * 
     * {param} string(sourceString) inStr : inputting String
     * 
     * {param} string(delimiter) delimiter : specify the delimiter
     * 
     * {param} int(count) count : if it is positive, count from beginning, return the front of the matching delimiter, <br>
     * if it is negative, count from tail, return the after of the matching delimiter, <br>
     * if it is zero, return empty
     * 
     * {example} mid_index(",1,2,3,4,", ",", 3) # ",1,2"
     * 
     * {example} mid_index(",1,2,3,4,", ",", -3) # "3,4,"
     * 
     * {example} mid_index(",1,2,3,4,", ",", 100) # ",1,2,3,4,"
     */
    public static String mid_index(String inStr, String delimiter, int count) {

        if (inStr == null || "".equals(inStr)) {
            return "";
        }
        if (count == 0) {
            return "";
        }
        if (inStr.indexOf(delimiter) == -1) {
            return inStr;
        }

        java.util.List<String> tmpList = new java.util.ArrayList<String>();
        String tmp = inStr, pi = "";
        int tmp_end = 0;

        while (!"".equals(tmp)) {
            tmp_end = tmp.indexOf(delimiter);

            if (tmp_end != -1) {
                pi = tmp.substring(0, tmp_end);
                tmp = tmp.substring(tmp_end + 1);
            } else {
                pi = tmp;
                tmp = "";
            }
            tmpList.add(pi);
        }

        // add last part ""
        if (inStr.endsWith(delimiter))
            tmpList.add("");

        int actualCount = tmpList.size();
        int absCount = Math.abs(count);

        if (absCount > actualCount)
            absCount = actualCount;

        int start_index = 0, end_index = 0;

        if (count > 0) {
            start_index = 0;
            end_index = absCount - 1;
        } else {
            start_index = actualCount - absCount;
            end_index = actualCount - 1;
        }

        String retStr = "";

        for (int i = start_index; i <= end_index; i++) {
            if (i != start_index)
                retStr = retStr.concat(delimiter);

            retStr = retStr.concat(tmpList.get(i));
        }
        return retStr;
    }

    /*
     * DOC ytao Comment method "main".
     * 
     * @param args
     */
    // public static void main(String[] args) {
    // // TODO Auto-generated method stub
    // String in = "";
    //
    // // mid
    // in = "12345678";
    // System.out.println("mid in: " + in);
    // System.out.println("mid return: " + mid(in, 2, 10));
    //
    // // mid_index
    // in = "12,3,...,.";
    // System.out.println("=======\nmid_index in: " + in);
    // System.out.println("mid_index return: " + mid_index(in, ",", -1));
    //
    // }
}
