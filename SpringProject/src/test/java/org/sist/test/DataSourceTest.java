package org.sist.test;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class DataSourceTest {
	@Inject
	private DataSource ds;
	
	public DataSource getDs() {
		return ds;
	}

	public void setDs(DataSource ds) {
		this.ds = ds;
	}

	@Test
	public void testConnection() throws Exception {
		try (Connection conn = ds.getConnection()){
			System.out.println(conn);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}