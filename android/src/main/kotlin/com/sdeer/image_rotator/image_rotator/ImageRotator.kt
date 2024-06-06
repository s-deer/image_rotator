import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import java.io.File
import java.io.FileOutputStream

class ImageRotator {
    fun rotateImage(inputFile: File, degrees: Float, outputFile: File) {
        val bitmap = BitmapFactory.decodeFile(inputFile.path)
        val matrix = Matrix()
        matrix.postRotate(degrees)
        val rotatedBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)

        val outputStream = FileOutputStream(outputFile)
        rotatedBitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
        outputStream.close()
    }
}