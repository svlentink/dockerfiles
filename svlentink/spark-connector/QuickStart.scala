import com.couchbase.spark._
import com.couchbase.spark.sql._
import com.couchbase.client.java.document.JsonDocument
import com.couchbase.client.java.document.json.JsonObject
import org.apache.spark.sql.{Row, SparkSession}
import org.apache.spark.{SparkConf, SparkContext}
object Main {
  def main(args: Array[String]): Unit = {
    // Configure Spark
    val cfg = new SparkConf()
      .setAppName("MyApp")
      .setMaster("local[*]")
      .set("com.couchbase.nodes","couchbase")
      .set("com.couchbase.bucket.travel-sample", "")

    // Generate The Context
    val sc = new SparkContext(cfg)
    //create RDD
    sc
        .couchbaseGet[JsonDocument](Seq("airline_10123", "airline_10748"))
        .collect()
        .foreach(println)
  }
}
