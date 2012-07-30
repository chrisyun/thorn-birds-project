package org.thorn.core.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.List;
import java.util.zip.CRC32;
import java.util.zip.CheckedOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: ZipUtils
 * @Description:
 * @author chenyun
 * @date 2012-7-27 下午04:23:27
 */
public class ZipUtils {

	private static Logger log = LoggerFactory.getLogger(ZipUtils.class);

	public static void packFile(List<File> files, String zipPath)
			throws IOException {
		File zipFile = new File(zipPath);
		// 创建zip文件
		zipFile.createNewFile();

		packFile(files, zipFile);
	}

	public static void packFile(List<File> files, File zipFile)
			throws FileNotFoundException {

		byte b[] = new byte[5120];
		ZipOutputStream out = null;
		FileOutputStream fileOs = null;
		CheckedOutputStream cs = null;
		
		try {
			fileOs = new FileOutputStream(zipFile);

			// 使用输出流检查
			cs = new CheckedOutputStream(fileOs,
					new CRC32());
			// 声明输出zip流
			out = new ZipOutputStream(new BufferedOutputStream(cs));
			
			String fileName;
			InputStream in = null;
			ZipEntry e = null;

			for (File file : files) {
				in = new FileInputStream(file);
				fileName = file.getName();

				e = new ZipEntry(fileName);

				try {
					out.putNextEntry(e);
					int len = 0;
					while ((len = in.read(b)) != -1) {
						out.write(b, 0, len);
					}
				} catch (IOException e1) {
					log.error(fileName + " add into zip failed,"
							+ e1.getMessage());
				} finally {
					if (in != null) {
						try {
							in.close();
						} catch (IOException e1) {
						}
					}
					try {
						out.closeEntry();
					} catch (IOException e1) {
						log.warn("ZipOutputStream closeEntry error");
					}
				}
			}
		} finally {
			if(out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}

	public static void unPackFile(String zipPath, String destFolder)
			throws IOException {
		File zipFile = new File(zipPath);

		unPackFile(zipFile, destFolder);
	}

	public static void unPackFile(File zipFile) throws IOException {

		int index = zipFile.getName().lastIndexOf(".");
		String destFolder = zipFile.getParent() + File.separator
				+ zipFile.getName().substring(0, index);

		unPackFile(zipFile, destFolder);
	}

	public static void unPackFile(File zipFile, String destFolder)
			throws IOException {
		File dest = new File(destFolder);
		dest.mkdirs();

		byte b[] = new byte[5120];
		ZipFile zip = new ZipFile(zipFile);
		Enumeration<ZipEntry> e = (Enumeration<ZipEntry>) zip.entries();
		
		ZipEntry zipEntry = null;
		InputStream in = null;
		FileOutputStream out = null;
		String fileName;
		try {
			while (e.hasMoreElements()) {
				zipEntry = e.nextElement();
				fileName = zipEntry.getName();
				
				File file = new File(dest, fileName);
				try {
					file.createNewFile();
					in = zip.getInputStream(zipEntry);
					out = new FileOutputStream(file);

					int len = 0;
					while ((len = in.read(b)) != -1) {
						out.write(b, 0, len);
					}

				} catch (IOException e1) {
					log.error(fileName + " unZip failed," + e1.getMessage());
				} finally {
					if(in != null) {
						try {
							in.close();
						} catch (IOException e1) {
						}
					}
					if(out != null) {
						try {
							out.close();
						} catch (IOException e1) {
						}
					}
				}
			}
		} finally {
			if(zip != null) {
				try {
					zip.close();
				} catch (IOException e1) {
				}
			}
		}
	}

}
