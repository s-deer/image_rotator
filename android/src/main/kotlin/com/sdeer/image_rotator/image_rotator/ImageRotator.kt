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


        val croppedBitmap = cropToNewRatio(bitmap=rotatedBitmap);

        saveBitmapToFile(bitmap=croppedBitmap, file=outputFile)
    }

    private fun cropToNewRatio(bitmap: Bitmap): Bitmap {
        val desiredWidth = if (bitmap.width > bitmap.height) {
            (bitmap.height.toDouble() / 3 * 4).toInt()
        } else {
            bitmap.width
        }
        val desiredHeight = if (bitmap.width > bitmap.height) {
            bitmap.height
        } else {
            (bitmap.width.toDouble() / 3 * 4).toInt()
        }

        val startX = if (bitmap.width > bitmap.height) {
            (bitmap.width - desiredWidth) / 2
        } else {
            0
        }
        val startY = if (bitmap.width > bitmap.height) {
            0
        } else {
            (bitmap.height - desiredHeight) / 2
        }

        return Bitmap.createBitmap(bitmap, startX, startY, desiredWidth, desiredHeight)
    }


    private fun saveBitmapToFile(bitmap: Bitmap, file: File) {
        val fileOutputStream = FileOutputStream(file)
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fileOutputStream)
        fileOutputStream.flush()
        fileOutputStream.close()
    }
}